class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
    @tag_list = Tag.all
    @q = Review.ransack(params[:q])
    @review = @q.result(distinct: true)
    @tag_search = Tag.ransack(params[:tag_search])
    @tag_reviews = @tag_search.result(distinct: true)
    @reviews_score = @user.reviews.average(:score)
    @like_count = 0
    @reviews.each do |review|
      @like_count += review.favorites.count
    end
  end
end
