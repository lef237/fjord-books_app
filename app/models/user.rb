# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  has_many :follower, class_name: "FollowRelationship", foreign_key: "follower_id", dependent: :destroy # followerテーブル（follower_idを起点にしたテーブル）
  has_many :followed, class_name: "FollowRelationship", foreign_key: "followed_id", dependent: :destroy # followedテーブル（followed_idを起点にしたテーブル）
  has_many :following_user, through: :follower, source: :followed # 自分がフォローしている人
  has_many :follower_user, through: :followed, source: :follower # 自分をフォローしている人
end
