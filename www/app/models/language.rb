class Language < ActiveRecord::Base
  belongs_to :proficiency
  belongs_to :resume
end
