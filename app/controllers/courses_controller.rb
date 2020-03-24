class CoursesController < ApplicationController
  load_and_authorize_resource
  def index
    @courses = Course.where(state: 'approved')
  end

  def show
    @course = Course.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'Course does not exist'
    redirect_to root_path
  end
end

