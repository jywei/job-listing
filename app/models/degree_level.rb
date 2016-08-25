class DegreeLevel < ActiveRecord::Base
   has_many :school
  has_many :preferred_candidates
end
