class Review < ApplicationRecord
   belongs_to :user
   has_many :post_comments, dependent: :destroy
   has_many :favorites, dependent: :destroy
   has_many :tag_maps, dependent: :destroy, foreign_key: "review_id" #独自
   has_many :tags, through: :tag_maps #独自
   
   def favorited_by?(user)
      favorites.where(user_id: user.id).exists?
   end
   
   def save_tag(sent_tags)
      # current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
      # old_tags = current_tags - sent_tags
      # new_tags = sent_tags - current_tags
      
      # old_tags.each do |old|
      #    self.tags.delete Tag.find_by(tag_name:old)
      # end
      
      sent_tags.each do |sent|
         new_post_tag = Tag.find_or_create_by(tag_name:sent)
         TagMap.new(review_id: self.id, tag_id: new_post_tag.id).save
         #new_post_tag = self.Tag.find_or_create_by(tag_name:new)
         #self.tags << new_post_tag
      end
   end
   
end
