class Post < ApplicationRecord
  belongs_to :user
  has_many :post_category_relations
  has_many :categories, through: :post_category_relations
  has_many :post_comments, dependent: :destroy
  validates :tweet, presence: true
  validates :title, presence: true
end
