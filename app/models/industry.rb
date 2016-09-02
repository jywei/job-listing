class Industry < ActiveRecord::Base
  has_many :jobs
  has_many :companies

  def self.options_for_select
    order('LOWER(name)').map { |e| [e.name, e.id] }
  end
end
