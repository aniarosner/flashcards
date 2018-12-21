class CoursesController < ApplicationController
  def index
    respond_to do |format|
      format.json { render json: Courses::ReadModel.new.all, status: :ok }
      format.html { render action: :index, locals: { courses: Courses::ReadModel.new.all } }
    end
  end

  def create
    respond_to do |format|
      format.json do
        command_bus.call(Content::CreateCourse.new(course_uuid: params[:course_uuid]))
        command_bus.call(Content::SetCourseTitle.new(course_uuid: params[:course_uuid], title: params[:title]))

        head :no_content
      end
    end
  end

  def destroy
    respond_to do |format|
      format.json do
        command_bus.call(Content::RemoveCourse.new(course_uuid: params[:course_uuid]))
        head :no_content
      end
    end
  end
end
