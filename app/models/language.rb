class Language < ActiveRecord::Base
  belongs_to :proficiency
  belongs_to :resume

  belongs_to :preferred_candidate
end
