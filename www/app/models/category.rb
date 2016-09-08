class Category < ActiveRecord::Base
  has_many :jobs
  has_many :preferred_candidates
  has_many :desired_jobs_roles

  def self.options_for_select
    order('LOWER(name)').map { |e| [e.name, e.id] }
  end
end
