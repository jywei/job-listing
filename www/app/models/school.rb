class School < ActiveRecord::Base
  belongs_to :degree_level
  belongs_to :resume
  belongs_to :university
  validates :field_of_study, presence: true
  validates :grade, presence: true
end
