class Paper < ApplicationRecord
  belongs_to :student, class_name: 'User'
  belongs_to :assignment

  state_machine initial: :in_progress do
    event :submit do
      transition in_progress: :submitted
    end
    event :check do
      transition submitted: :marked
    end
  end
end
