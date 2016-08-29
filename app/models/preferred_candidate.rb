class PreferredCandidate < ActiveRecord::Base
  belongs_to :job

  belongs_to :location
  belongs_to :country
  belongs_to :contract_type
  belongs_to :category
  belongs_to :degree_level
  belongs_to :related_experience
  belongs_to :career_level

  has_many :languages
  accepts_nested_attributes_for :languages, allow_destroy: true

end
