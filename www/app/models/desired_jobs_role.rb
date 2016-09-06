class DesiredJobsRole < ActiveRecord::Base
  belongs_to :resume
  belongs_to :category
end

