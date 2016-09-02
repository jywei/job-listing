class Language < ActiveRecord::Base
  has_one :proficiency
  has_one :language_skill
  belongs_to :resume

  belongs_to :preferred_candidate
end
