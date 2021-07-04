class PostCommentsController < ApplicationController
  
  def create
    review = Review.find(params[:review_id])
    @post_comment = current_user.post_comments.new(post_comment_params)
    @post_comment.review_id = review.id
    if @post_comment.save
      redirect_to review_path(review)
    else
      @review = Review.find(params[:review_id])
      @post_tags = @review.tags
      @all_comments = PostComment.all
      render template: "reviews/show"
    end
  end

  def destroy
    PostComment.find_by(id: params[:id], review_id: params[:review_id]).destroy
    redirect_to review_path(params[:review_id])
  end
  
  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
  
end
