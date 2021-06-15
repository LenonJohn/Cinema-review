class ReviewsController < ApplicationController
  def new
    @new_review = Review.new
  end
  
  def create
    @new_review = Review.new(review_params)
    @new_review.user_id = current_user.id
    # tag_list = params[:review][:tag_name].split(nil) 
    tag_list = params[:tag_name].split(nil) 
    @new_review.save
    @new_review.save_tag(tag_list)
    redirect_to reviews_path
  end

  def index
    @review = Review.all
    @tag_list = Tag.all
  end
  
  def tag_search
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @tag_reviews = @tag.reviews.all
  end
  
  def show
    @review = Review.find(params[:id])
    @post_tags = @review.tags
    @post_comment = PostComment.new
    @all_comments = PostComment.all
  end

  def destroy
    @review = Review.find(params[:id])
    @review.tags.each do |tag|
      if tag.reviews.count == 1
        tag.destroy!
      end
    end
    @review.destroy!
    redirect_to reviews_path
  end
  
  private
  
  def review_params
    params.permit(:cinema_title, :rate, :title, :body)
  end
  
end
