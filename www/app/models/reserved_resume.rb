class ReservedResume < ActiveRecord::Base
  belongs_to :favorite_resume, class_name: "Resume", foreign_key: 'favorite_resume_id'
  belongs_to :tracking_company, class_name: "Company", foreign_key: 'tracking_company_id'
end
