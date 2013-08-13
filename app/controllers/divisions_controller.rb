class DivisionsController < ApplicationController
  def index
    @divisions = current_user.divisions
  end

  def show
    @division = Division.find_by_id(params[:id])
    @users = @division.users.includes(:members).order('members.points DESC')
  end
end
