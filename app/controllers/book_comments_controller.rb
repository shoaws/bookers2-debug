class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @user = @book.user
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = @book.id
    if @comment.save
    else
      @book_comment = BookComment.new
      render 'books/show'
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    @user = @book.user

    @comment = BookComment.find(params[:id])
    @comment.destroy
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
