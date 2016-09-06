class DesiredJobsIndustry < ActiveRecord::Base
  belongs_to :resume
  belongs_to :industry
end
