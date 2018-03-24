class DivisionsController < ApplicationController
  def index
    @divisions = current_user.divisions.includes(:skill, :league)
  end

  def show
    @division = Division.find_by_id(params[:id])
    @members = @division.members.includes(:user).order('members.points DESC')
  end
end
