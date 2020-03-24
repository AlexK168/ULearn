class Teacher::CoursesController < ApplicationController
  load_and_authorize_resource
  skip_load_resource only: :new
  def index_mine
    render :index
  end

  def show_mine
    render :show
  end

  def new
    @course = Course.new
  end

  def create
    @course = current_user.courses.new(course_params)
    if @course.save
      redirect_to course_path(@course)
      flash[:success] = 'Course successfully created'
    else
      flash.now[:error] = 'Unable to create course'
      render :new
    end
  end

  def update
    if @course.update(course_params)
      redirect_to course_path(@course)
      flash[:success] = 'Course successfully updated'
    else
      flash.now[:error] = 'Unable to update course'
      render :new
    end
  end

  def edit
    render :new
  end

  def destroy
    if @course.destroy
      flash[:success] = 'Course was successfully deleted'
    else
      flash[:error] = "Can't delete course"
    end
    redirect_to root_path
  end

  private

  def course_params
    params.require(:course).permit(:info, :name, :duration)
  end
end
