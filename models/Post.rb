class Post < ActiveRecord::Base
    belongs_to :user
    has_many :post_tags
    has_many :tags, through: :post_tags

    def date_form
        self.created_at.strftime("%B %d, %Y")
      end
end