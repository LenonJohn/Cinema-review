class ReviewsController < ApplicationController
  
  def create
    @new_review = Review.new(review_params)
    @new_review.user_id = current_user.id
    tag_list = params[:review][:tag_name].split(nil) 
    #tag_list = params[:tag_name].split(nil) 
    if @new_review.save
      @new_review.save_tag(tag_list)
      redirect_to reviews_path
    else
      @tag_list = Tag.all
      @q = Review.ransack(params[:q])
      @tag_search = Tag.ransack(params[:tag_search])
      @tag_reviews = @tag_search.result(distinct: true)
      if params[:sort_select] == "new_arrival"
        @reviews = Review.order("created_at ASC")
      elsif params[:sort_select] == "topic_work"
        @reviews = Review.find(Favorite.group(:review_id).order('count(review_id) desc').pluck(:review_id))
      else
        @reviews = @q.result(distinct: true)
      end
      render :index
    end
  end

  def index
    @new_review = Review.new
    @tag_list = Tag.all
    @q = Review.ransack(params[:q])
    @tag_search = Tag.ransack(params[:tag_search])
    @tag_reviews = @tag_search.result(distinct: true)
    if params[:sort_select] == "new_arrival"
      @reviews = Review.order("created_at ASC")
    elsif params[:sort_select] == "topic_work"
      @reviews = Review.find(Favorite.group(:review_id).order('count(review_id) asc').pluck(:review_id))
    else
      @reviews = @q.result(distinct: true)
    end
  end
  
  def search
    @tag_list = Tag.all
    @q = Review.ransack(params[:q])
    @review = @q.result(distinct: true)
    @tag_search = Tag.ransack(params[:q])
    @tag_reviews = @tag_search.result(distinct: true)
  end
  
  def tag_search
    @tag_list = Tag.all
    @q = Review.ransack(params[:q])
    @review = @q.result(distinct: true)
    @tag_search = Tag.ransack(params[:q])
    @tag_reviews = @tag_search.result(distinct: true)
    @tag = Tag.ransack(params[:q])
    @tags = @tag.result(distinct: true)
    @reviews = []
    if @tags.length > 0
      @tags.each do |tag|
        tagmaps = TagMap.where(tag_id: tag.id)
        tagmaps.each do |tag_map|
          review = Review.find(tag_map.review_id)
          @reviews.push(review)
        end
      end
    end
    @reviews
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
    params.require(:review).permit(:cinema_title, :rate, :title, :body)
  end
  
  def search_params
    params.require(:q).permit!
    params.require(:t).permit!
  end
  
end
