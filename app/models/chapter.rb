class Chapter < ApplicationRecord
  has_many :lectures
  has_many :assignments, through: :lectures, class_name: 'Assignment'
  belongs_to :course
end
