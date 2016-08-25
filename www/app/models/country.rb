class Country < ActiveRecord::Base
  has_many :companies
  has_many :jobs
  has_many :experiences
end
