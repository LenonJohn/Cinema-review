class PostCommentsController < ApplicationController
  
  def create
    review = Review.find(params[:review_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.review_id = review.id
    comment.save
    redirect_to review_path(review)
  end

  def destroy
  end
  
  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
  
end
