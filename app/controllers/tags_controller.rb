class TagsController < ApplicationController
  
  def index
   @tag = Tag.all
  end
  
  def show
    @tag_list = Tag.all
    @tag = Tag.find(params[:id])
    @tag_reviews = @tag.reviews.all
  end
  
end
