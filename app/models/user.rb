class User < ApplicationRecord
    has_many :articles, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :likes, dependent: :destroy
end
