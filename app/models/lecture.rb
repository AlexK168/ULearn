class Lecture < ApplicationRecord
  belongs_to :chapter
  has_one :assignment
end
