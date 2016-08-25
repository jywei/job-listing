class EmployeeRange < ActiveRecord::Base
  has_many :companies

  def self.options_for_select
    order('created_at').map { |e| [e.range, e.id] }
  end
end
