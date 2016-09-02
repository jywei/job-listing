class ReservedJob < ActiveRecord::Base
  belongs_to :favorite_job, class_name: "Job", foreign_key: 'favorite_job_id'
  belongs_to :tracking_user, class_name: "User", foreign_key: 'tracking_user_id'
end
