class RelatedExperience < ActiveRecord::Base
  has_many :preferred_candidates
end
