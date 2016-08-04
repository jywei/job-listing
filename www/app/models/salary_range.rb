class SalaryRange < ActiveRecord::Base
  has_many :jobs

  def self.options_for_select
    order('created_at').map { |e| [e.range, e.id] }
  end
end
