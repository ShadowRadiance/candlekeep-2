class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :require_admin!, except: [:index, :show]

  def index
    @books = Book.includes(:copies).all
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new(pages: 0)
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to @book, notice: 'Book created successfully.'
    else
      flash.now[:error] = 'Could not save book'
      render action: 'new'
    end

  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    @book.assign_attributes(book_params)

    if @book.save
      redirect_to @book, notice: 'Book updated successfully.'
    else
      flash.now[:error] = 'Could not save book'
      render action: 'edit'
    end

  end

  def delete
    @book = Book.find(params[:id])

  end

  private

  def book_params
    params.require(:book).permit(:title, :author,
                                 :genre, :subgenre,
                                 :pages, :publisher)
  end

end
