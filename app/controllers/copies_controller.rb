class CopiesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!

  before_action :set_copy, only: [:destroy, :restore]

  def create
    book = Book.find(params[:book_id])
    branch = Branch.find(params[:branch_id])
    copy = book.copies.create(branch: branch)
    if copy.valid?
      redirect_to book, notice: 'Added a new copy'
    else
      redirect_to book, alert: 'Error adding copy: ' + copy.errors.full_messages.to_sentence
    end
  end

  def destroy
    @copy.update(destroyed_at: Time.current)
    redirect_to @copy.book, notice: 'Copy deleted'
  end

  def restore
    @copy.update(destroyed_at: nil)
    redirect_to @copy.book, notice: 'Copy restored!'
  end

  private

  def set_copy
    @copy = Copy.find(params[:id])
  end
end