class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def index
    @checkouts = Checkout.active.where(user: current_user)
    render 'user_index'
  end

  def admin_index
    require_admin!

    checkouts = Checkout.active
    @checkouts_by_user_id = {}
    checkouts.each do |checkout|
      @checkouts_by_user_id[checkout.user.id] ||= {
        user: checkout.user,
        checkouts: []
      }
      @checkouts_by_user_id[checkout.user.id][:checkouts] << checkout
    end
    render 'admin_index'
  end

  def create
    book = Book.find(params[:book_id])
    branch = Branch.find(params[:branch_id])
    checkout_copy(acquire_copy(book,branch))
    redirect_back fallback_location: books_path, notice: 'Checkout successful'
  rescue StandardError => e
    redirect_back fallback_location: books_path, alert: e.message
  end

  def destroy
    checkout = Checkout.find(params[:id])
    checkout.update(checked_in_at: Time.current)
    if checkout.valid?
      notify_waiting_members(checkout.copy.book)
      redirect_back fallback_location: checkouts_path, notice: 'Thanks for returning the book'
    else
      redirect_back fallback_location: checkouts_path, alert: checkout.errors.full_messages.to_sentence
    end
  end

  private

  def acquire_copy(book, branch)
    book.copies_at(branch).available.first.tap do |copy|
      raise('No Copies Available') if copy.nil?
    end
  end

  def checkout_copy(copy)
    checkout_time = Time.current
    checkout = Checkout.create(copy: copy,
                               user: current_user,
                               checked_out_at: checkout_time)
    raise checkout.errors.full_messages.to_sentence unless checkout.valid?
    checkout
  end

  def notify_waiting_members(book)
    NotificationRequest.where(book: book).each do |req|
      UserMailer.with(notification_request: req).notification_email.deliver_now
    end
  end
end