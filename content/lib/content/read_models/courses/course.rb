module Content
  module Courses
    class Course < ActiveRecord::Base
      self.table_name = 'content_courses_courses'
    end
  end
end
