class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book.id)
  end

  def index
    @book = Book.new
    @user = current_user
    @books = Book.all
  end

  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id]) #bookの取得
    @book.update(book_params) #bookのアップデート
    redirect_to book_path(@book.id) #bookの詳細ページへのパス
  end

  def destroy
    @book = Book.find(params[:id]) #bookの取得
    @book.destroy # データ（レコード）を削除
    redirect_to '/books'
  end

  private

  def book_params #ストロングパラメータ
    params.require(:book).permit(:title, :body)
  end

end
