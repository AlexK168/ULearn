class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :login, :email, uniqueness: true
  validates :role, inclusion: { in: %w[student teacher admin] }
  before_validation :set_role, :normalize_name, on: :create
  # scope :teachers, -> { where("role = 'teacher'") }
  # scope :students, -> { where("role = 'student'") }
  # scope :admins, -> { where("role = 'admin'") }
  has_many :super_groups, foreign_key: 'teacher_id', class_name: 'Group'
  has_and_belongs_to_many :groups, foreign_key: 'student_id', association_foreign_key: 'group_id'
  has_many :courses, foreign_key: 'teacher_id'
  has_many :papers, foreign_key: 'student_id'

  def access_to?(resource)
    return false if groups.empty?

    groups = self.groups
    case resource.class
    when 'Chapter'
      course_id = resource.course.id
    when 'Lecture'
      course_id = resource.chapter.course.id
    when 'Assignment'
      course_id = resource.lecture.chapter.course.id
    end
    groups.find_each do |g|
      return true if g.course_id == course_id
    end
    false
  end

  def role?(role)
    self.role.to_sym == role
  end

  private

  def normalize_name
    self.name = name.downcase.titleize
  end

  def set_role
    self.role = 'student'
  end


end
