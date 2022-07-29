# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  # follower_relationshipsテーブル（follower_idを起点にしたテーブル）
  has_many :follower_relationships, class_name: 'FollowRelationship', foreign_key: 'follower_id', dependent: :destroy, inverse_of: :follower
  # followed_relationshipsテーブル（followed_idを起点にしたテーブル）
  has_many :followed_relationships, class_name: 'FollowRelationship', foreign_key: 'followed_id', dependent: :destroy, inverse_of: :followed
  # 自分がフォローしている人
  has_many :followings, through: :follower_relationships, source: :followed
  # 自分をフォローしている人
  has_many :followers, through: :followed_relationships, source: :follower

  # ユーザーをフォローする
  def follow(other_user)
    followings << other_user
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    follower_relationships.find_by(followed_id: other_user.id).destroy
  end

  # フォローしていればtrueを返す
  def following?(other_user)
    followings.include?(other_user)
  end
end
