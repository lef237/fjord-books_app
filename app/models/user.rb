# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  has_many :follower_relationships, class_name: "FollowRelationship", foreign_key: "follower_id", dependent: :destroy # follower_relationshipsテーブル（follower_idを起点にしたテーブル）
  has_many :followed_relationships, class_name: "FollowRelationship", foreign_key: "followed_id", dependent: :destroy # followed_relationshipsテーブル（followed_idを起点にしたテーブル）
  has_many :followings, through: :follower_relationships, source: :followed # 自分がフォローしている人
  has_many :followers, through: :followed_relationships, source: :follower # 自分をフォローしている人

  # ユーザーをフォローする
  def follow(user_id)
    follower_relationships.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower_relationships.find_by(followed_id: user_id).destroy
  end

  # フォローしていればtrueを返す
  def following?(user)
    followings.include?(user)
  end

end
