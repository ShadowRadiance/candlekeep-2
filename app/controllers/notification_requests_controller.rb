class NotificationRequestsController < ApplicationController
  before_action :authenticate_user!


  def create
    book = Book.find(params[:book_id])
    request = NotificationRequest.create(book: book, user: current_user)

    if request.valid?
      redirect_back fallback_location: books_path, notice: "Thanks, we'll let you know when that book is back in"
    else
      redirect_back fallback_location: books_path, alert: request.errors.full_messages.to_sentence
    end
  end

end
