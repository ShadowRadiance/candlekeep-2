class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def create
    book = Book.find(params[:book_id])
    checkout_copy(acquire_copy(book))
    redirect_back fallback_location: books_path, notice: 'Checkout successful'
  rescue StandardError => e
    redirect_back fallback_location: books_path, alert: e.message
  end


  private

  def acquire_copy(book)
    book.copies.available.first.tap do |copy|
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

end