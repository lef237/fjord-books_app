# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.with_attached_avatar.order(:id).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def followings
    @title = 'Following'
    @user  = User.includes(:followings).find(params[:id])
    @users = @user.followings.with_attached_avatar.page(params[:page])
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @user  = User.includes(:followers).find(params[:id])
    @users = @user.followers.with_attached_avatar.page(params[:page])
    render 'show_follow'
  end
end
