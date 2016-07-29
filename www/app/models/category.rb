class Category < ActiveRecord::Base
  has_many :jobs

  def self.options_for_select
    order('LOWER(name)').map { |e| [e.name, e.id] }
  end
end
