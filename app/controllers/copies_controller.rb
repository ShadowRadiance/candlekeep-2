class CopiesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!

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
    @copy = Copy.find(params[:id])
    @copy.update(destroyed_at: Time.current)
    redirect_to @copy.book, notice: 'Copy deleted'
  end

  def restore
    @copy = Copy.find(params[:id])

    @copy.update(destroyed_at: nil)
    redirect_to @copy.book, notice: 'Copy restored!'
  end
end