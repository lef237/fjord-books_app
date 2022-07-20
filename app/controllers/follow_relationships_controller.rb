class FollowRelationshipsController < ApplicationController
  # フォローするとき
  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    redirect_to user
  end
  # フォロー外すとき
  def destroy
    user = FollowRelationship.find(params[:id]).followed
    current_user.unfollow(user)
    redirect_to user
  end
  # フォロー一覧
  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end
  # フォロワー一覧
  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end
end
