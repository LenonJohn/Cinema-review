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
  end

  def destroy
  end
  
  private
  
  def review_params
    params.permit(:title, :body)
  end
  
end
