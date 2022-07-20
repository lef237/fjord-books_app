# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  has_many :follower_relationships, class_name: "FollowRelationship", foreign_key: "follower_id", dependent: :destroy # follower_relationshipsテーブル（follower_idを起点にしたテーブル）
  has_many :followed_relationships, class_name: "FollowRelationship", foreign_key: "followed_id", dependent: :destroy # followed_relationshipsテーブル（followed_idを起点にしたテーブル）
  has_many :followings, through: :follower_relationships, source: :followed # 自分がフォローしている人
  has_many :followers, through: :followed_relationships, source: :follower # 自分をフォローしている人

  def follow(other_user)
    unless self == other_user
      self.follower_relationships.find_or_create_by(followed_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.follower_relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

end
