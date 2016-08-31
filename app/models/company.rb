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

  filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: [
      :sorted_by,
      :search_query,
      :with_industry_id,
      :with_location_id,
      :with_employee_range_id,
      :with_vacancy_numbers
    ]
  )

  self.per_page = 10

  scope :search_query, -> (query) {
    return nil if query.blank?
    # condition query, parse into individual keywords
    terms = query.downcase.split(/\s+/)
    # replace "*" with "%" for wildcard searches,
    # append '%', remove duplicate '%'s
    terms = terms.map { |e|
      (e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    num_or_conditions = 6

    where(
      terms.map {
        or_clauses = [
          "LOWER(companies.name) LIKE ?",
          "LOWER(companies.about) LIKE ?",
          "LOWER(companies.story) LIKE ?",
          "LOWER(companies.welfare) LIKE ?",
          "LOWER(companies.demand) LIKE ?",
          "LOWER(companies.idea) LIKE ?"
        ].join(' OR ')
        "(#{ or_clauses })"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conditions }.flatten
    )
  }

  scope :sorted_by, -> (sort_option) {
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^created_at_/
      order("companies.created_at #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  scope :with_industry_id, -> (industry_ids) {
    industry_ids.select! {|ele| ele != ""}
    where(industry_id: [*industry_ids]) if industry_ids.present?
  }

  scope :with_location_id, -> (location_ids) {
    location_ids.select! {|ele| ele != ""}
    where(location_id: [*location_ids]) if location_ids.present?
  }

  scope :with_employee_range_id, -> (employee_range_ids) {
    employee_range_ids.select! {|ele| ele != ""}
    where(employee_range_id: [*employee_range_ids]) if employee_range_ids.present?
  }

  scope :with_vacancy_numbers, -> (vacancy_numbers) {
    vacancy_numbers.select! {|ele| ele != ""}
    if vacancy_numbers.present? && vacancy_numbers.first == 1
      where(jobs_count: 1)
    elsif vacancy_numbers.present? && vacancy_numbers.first == 2
      where(jobs_count: (2..3))
    elsif vacancy_numbers.present? && vacancy_numbers.first == 3
      where("jobs_count >= 4")
    end
  }

  delegate :name, to: :industry, prefix: true
  delegate :name, to: :location, prefix: true
  delegate :range, to: :employee_range, prefix: true #.employee_range_range

  def self.options_for_sorted_by
    [
      ['Recently Listed (newest first)', 'created_at_desc'],
      ['Recently Listed (oldest first)', 'created_at_asc']
    ]
  end

end
