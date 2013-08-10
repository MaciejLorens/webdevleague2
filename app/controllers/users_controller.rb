class UsersController < ApplicationController
  def index
    @users = User.all.order('nick')
  end

  def show
    @user = User.find_by_id params[:id]
  end
end
