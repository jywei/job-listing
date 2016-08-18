class Company < ActiveRecord::Base
  has_attached_file :image,
                    styles: { medium: "300x300>", thumb: "100x100>", micro: "40x40>" },
                    default_url: "nia.png"

  has_attached_file :cover,
                    styles: { cover: "700x300>", preview: "230x100>" },
                    default_url: "backg.png"

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_attachment_content_type :cover, content_type: /\Acover\/.*\Z/

  has_many :jobs
  has_many :impressions, as: :impressionable

  has_many :following_users, class_name: 'User', through: :reserved_companies
  has_many :reserved_companies, foreign_key: 'favorite_company_id'

  belongs_to :industry
  belongs_to :employee_range
  belongs_to :country
  belongs_to :location
  belongs_to :user

  default_scope { where(is_hiring: true) }

  scope :most_jobs, -> { order("jobs_count DESC").limit(6) }

  def impression_count
    impressions.size
  end

  def self.options_for_select
    order('LOWER(name)').map { |e| [e.name, e.id] }
  end

end
