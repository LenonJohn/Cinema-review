class TagsController < ApplicationController
  
  def index
   @tag = Tag.all
  end
  
  def show
    @tag_list = Tag.all
    @tag = Tag.find(params[:id])
    @tag_review = @tag.reviews.all
    @q = Review.ransack(params[:q])
    @review = @q.result(distinct: true)
    @tag_search = Tag.ransack(params[:tag_search])
    @tag_reviews = @tag_search.result(distinct: true)
  end
  
end
