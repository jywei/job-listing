class ReservedCompany < ActiveRecord::Base
  belongs_to :favorite_company, class_name: "Company", foreign_key: 'favorite_company_id'
  belongs_to :following_user, class_name: "User", foreign_key: 'following_user_id'
end
