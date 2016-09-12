class CoverLetter < ActiveRecord::Base
  belongs_to :job
  belongs_to :resume
end
