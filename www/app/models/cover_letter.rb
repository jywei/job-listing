class CoverLetter < ActiveRecord::Base
  belongs_to :job, counter_cache: :cover_letters_count
  belongs_to :resume
end
