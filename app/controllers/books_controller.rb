class BooksController < ApplicationController
  include HashtagMethods

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_comment = BookComment.new

    unless ViewCount.find_by(user_id: current_user.id, book_id: @book.id)
      current_user.view_counts.create(book_id: @book.id)
    end

  end

  def index
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    @books = Book.includes(:favorited_users).
      sort{|a,b|
        b.favorited_users.includes(:favorites).where(created_at: from...to).size <=>
        a.favorited_users.includes(:favorites).where(created_at: from...to).size
      }

    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    hashtag = extract_hashtag(@book.body)
    if @book.save
      save_hashtag(hashtag,@book)
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      delete_records_related_to_hashtag(params[:id])
      hashtag = extract_hashtag(@book.body)
      save_hashtag(hashtag,@book)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    delete_records_related_to_hashtag(params[:id])
    redirect_to books_path
  end

  def hashtag
    @user = current_user
    @tag = Hashtag.find_by(hashname: params[:name])
    @books = @tag.books
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end


end
