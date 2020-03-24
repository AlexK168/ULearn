class Group < ApplicationRecord
  belongs_to :teacher, -> { where role: 'teacher' }, foreign_key: :teacher_id, class_name: 'User'
  has_and_belongs_to_many :students,
                          class_name: 'User',
                          foreign_key: 'group_id',
                          association_foreign_key: 'student_id'
  belongs_to :course
  validates :max_size, numericality: {only_integer: true, greater_than: 0 }

  state_machine initial: :approved do
    event :start_recruiting do
      transition approved: :recruiting
    end

    event :finish_recruiting do
      transition recruiting: :ready
    end

    event :start_course do
      transition ready: :completing
    end

    event :finish_course do
      transition completing: :finished
    end

    state :finished do
      def delete_group; end
    end
  end
end
