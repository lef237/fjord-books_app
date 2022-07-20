# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.with_attached_avatar.order(:id).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).reverse_order
    @followings = @user.followings
    @followers = @user.followers
  end

  def followings
    user = User.find(params[:id])
    @users = user.followings.page(params[:page]).per(3).reverse_order
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers.page(params[:page]).per(3).reverse_order
  end
end
