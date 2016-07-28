class Job < ActiveRecord::Base
  belongs_to :category
  belongs_to :industry

  scope :published, -> { where(is_published: true) }

  def self.by_category_and_industry(category_id = nil, industry_id = nil)
    return where(category_id: category_id, industry_id: industry_id) if category_id && industry_id
    return where(category_id: category_id) if category_id
    return where(industry_id: industry_id) if industry_id
    all
  end

end
