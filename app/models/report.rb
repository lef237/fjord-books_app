class Report < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true
  has_many :comments, as: :commentable
end
