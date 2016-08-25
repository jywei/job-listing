class Language < ActiveRecord::Base
  belongs_to :proficiency
  belongs_to :resume
  belongs_to :language_skill
end
