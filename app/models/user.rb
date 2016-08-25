class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :company
  has_one :resume

  has_many :favorite_companies, class_name: 'Company', through: :reserved_companies
  has_many :reserved_companies, foreign_key: 'following_user_id'

  has_many :favorite_jobs, class_name: 'Job', through: :reserved_jobs
  has_many :reserved_jobs, foreign_key: 'tracking_user_id'
end
