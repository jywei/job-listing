class Language < ActiveRecord::Base
  has_one :proficiency
  has_one :language_skill
  belongs_to :resume
  belongs_to :language_code

  belongs_to :preferred_candidate
end
