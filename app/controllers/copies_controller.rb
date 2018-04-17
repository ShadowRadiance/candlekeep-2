class CopiesController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @copy = @book.copies.create
    if @copy.valid?
      redirect_to @book, notice: 'Added a new copy'
    else
      redirect_to @book, alert: 'Error adding copy: ' + @copy.errors.full_messages.to_sentence
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    @copy = @book.copies.find(params[:id])
    @copy.update(destroyed_at: Time.current)
    redirect_to @book, notice: 'Copy deleted'
  end

  def restore
    @book = Book.find(params[:book_id])
    @copy = @book.destroyed_copies.find(params[:id])

    @copy.update(destroyed_at: nil)
    redirect_to @book, notice: 'Copy restored!'
  end
end