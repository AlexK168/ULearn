class HomeController < ApplicationController
  def index
    @courses = Course.accessible_by(current_ability)
    render 'courses/index'
  end
end
