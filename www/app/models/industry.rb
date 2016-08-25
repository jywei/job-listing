class Industry < ActiveRecord::Base
  has_many :jobs
  has_many :companies
  has_many :experiences
  has_many :djis

  def self.options_for_select
    order('LOWER(name)').map { |e| [e.name, e.id] }
  end
end
