class Article < ApplicationRecord
    belongs_to :user
    has_many :article_categories
    has_many :categories, through: :article_category
    has_many :likes, dependent: :destroy
end
