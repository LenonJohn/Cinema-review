class ReviewsController < ApplicationController
  def new
    @new_review = Review.new
  end
  
  def create
    @new_review = Review.new(review_params)
    @new_review.user_id = current_user.id
    @new_review.save
    redirect_to reviews_path
  end

  def index
    @review = Review.all
  end
  
  def show
    @review = Review.find(params[:id])
    @post_comment = PostComment.new
    @all_comments = PostComment.all
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to reviews_path
  end
  
  private
  
  def review_params
    params.permit(:cinema_title, :rate, :title, :body)
  end
  
end
