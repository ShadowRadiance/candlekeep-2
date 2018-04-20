class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :require_admin!, except: [:index, :show]

  before_action :set_book, only: [:show, :edit, :update]
  before_action :set_branches, only: [:index, :show]

  def index
    @books = Book.includes(copies: [:branch]).all
  end

  def show; end

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

  def edit; end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: 'Book updated successfully.'
    else
      flash.now[:error] = 'Could not save book'
      render action: 'edit'
    end

  end

  private

  def set_book
    @book = Book.includes(copies: [:branch]).find(params[:id])
  end

  def set_branches
    @branches = Branch.all
  end

  def book_params
    params.require(:book).permit(:title, :author,
                                 :genre, :subgenre,
                                 :pages, :publisher)
  end
end
