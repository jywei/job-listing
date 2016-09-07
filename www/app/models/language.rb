class Language < ActiveRecord::Base
  has_one :fluency
  has_one :language_code

  belongs_to :resume
  belongs_to :language_skill

  belongs_to :preferred_candidate
end
