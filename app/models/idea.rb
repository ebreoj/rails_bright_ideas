class Idea < ActiveRecord::Base
  belongs_to :user  # author
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  validates :content, presence: true
end
