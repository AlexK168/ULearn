class Course < ApplicationRecord
  validates :name, presence: true
  validates :duration, numericality: {only_integer: true}
  validates :info, presence: true
  belongs_to :teacher, -> { where role: 'teacher' }, class_name: 'User', foreign_key: 'teacher_id'
  has_many :chapters
  has_many :lectures, through: :chapters, class_name: 'Lecture'

  state_machine initial: :pending do
    after_transition pending: :rejected, do: :remove_course
    event :approve do
      transition pending: :approved
    end

    event :reject do
      transition pending: :rejected
    end

    event :redraft do
      transition pending: :pending
    end

    state :pending do
      def send_request
        # send request to admin
      end
    end

    def remove_course
      # remove the whole course
    end
  end
end
