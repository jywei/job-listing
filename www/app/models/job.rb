class Job < ActiveRecord::Base
  resourcify

  scope :unpublished, -> { where(is_published: false) }
  scope :published, -> { where(is_published: true) }
  scope :expired, -> { where(status: "expired") }
  scope :not_expired, -> { where.not(status: "expired") }

  belongs_to :company, counter_cache: :jobs_count
  belongs_to :category, counter_cache: :jobs_count
  belongs_to :industry, counter_cache: :jobs_count
  belongs_to :contract_type, counter_cache: :jobs_count
  belongs_to :location, counter_cache: :jobs_count
  belongs_to :salary_range, counter_cache: :jobs_count
  belongs_to :country

  validates :title,               presence: true
  validates :description,         presence: true
  validates :requirement,         presence: true
  validates :apply_instruction,   presence: true
  validates :start_day,           presence: true
  validates :professional_skill,  presence: true

  has_many :impressions, as: :impressionable

  def impression_count
    impressions.size
  end

  filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: [
      :sorted_by,
      :search_query,
      :with_category_id,
      :with_industry_id,
      :with_contract_type_id,
      :with_location_id,
      :with_salary_range_id,
      :with_company_id,
      :with_posted_at_gte,
      :not_expired
    ]
  )

  # default for will_paginate
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
    num_or_conditions = 4

    # includes(:company)
    # .where(company: {name: name})
    # .where("title LIKE ?", title)
    # .where("description LIKE ?", description)

    joins(:company)
    .where(
      terms.map {
        or_clauses = [
          "LOWER(companies.name) LIKE ?",
          # "LOWER(locations.name) LIKE ?",
          # "LOWER(countries.name) LIKE ?",
          # "LOWER(categories.name) LIKE ?",
          # "LOWER(industries.name) LIKE ?",
          "LOWER(jobs.title) LIKE ?",
          "LOWER(jobs.description) LIKE ?",
          "LOWER(jobs.requirement) LIKE ?"
        ].join(' OR ')
        "(#{ or_clauses })"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conditions }.flatten
    )
    # num_or_conditions = 1
    # where(
    #   terms.map {
    #     or_clauses = [
    #       "LOWER(companies.name) LIKE ?"
    #     ].join(' OR ')
    #     "(#{ or_clauses })"
    #   }.join(' AND '),
    #   *terms.map { |e| [e] * num_or_conditions }.flatten
    # ).joins(:company)
  }

  scope :sorted_by, -> (sort_option) {
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^created_at_/
      order("jobs.created_at #{ direction }")
    when /^title_/
      order("LOWER(jobs.title) #{ direction }")
    # when /^industry_name_/
    #   order("LOWER(industries.name) #{ direction }").includes(:industry)
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  scope :with_industry_id, -> (industry_ids) {
    industry_ids.select! {|ele| ele != ""}
    where(industry_id: [*industry_ids]) if industry_ids.present?
  }

  scope :with_category_id, -> (category_ids) {
    category_ids.select! {|ele| ele != ""}
    where(category_id: [*category_ids]) if category_ids.present?
  }

  scope :with_contract_type_id, -> (contract_type_ids) {
    contract_type_ids.select! {|ele| ele != ""}
    where(contract_type_id: [*contract_type_ids]) if contract_type_ids.present?
  }

  scope :with_location_id, -> (location_ids) {
    location_ids.select! {|ele| ele != ""}
    where(location_id: [*location_ids]) if location_ids.present?
  }

  scope :with_company_id, -> (company_ids) {
    company_ids.select! {|ele| ele != ""}
    where(company_id: [*company_ids]) if company_ids.present?
  }

  scope :with_salary_range_id, -> (salary_range_ids) {
    salary_range_ids.select! {|ele| ele != ""}
    where(salary_range_id: [*salary_range_ids]) if salary_range_ids.present?
  }

  scope :with_posted_at_gte, -> (date) {
    where('created_at >= ?', date)
  }

  scope :not_expired, -> {
    where.not(status: "expired")
  }

  delegate :name, to: :industry, prefix: true
  delegate :name, to: :category, prefix: true
  delegate :name, to: :contract_type, prefix: true
  delegate :name, to: :location, prefix: true
  delegate :name, to: :company, prefix: true
  delegate :range, to: :salary_range, prefix: true

  def self.options_for_sorted_by
    [
      ['Title (a-z)', 'title_asc'],
      ['Recently Published (newest first)', 'created_at_desc'],
      ['Recently Published (oldest first)', 'created_at_asc']
    ]
  end

  def decorated_created_at
    created_at.to_date.to_s(:long)
  end

  def decorated_start_day
    start_day.to_s(:long)
  end

  def not_myanmar
    unless country_id == 150
      update_attributes(location_id: nil)
    end
  end

  # def expiration_check
  #   if start_day < Date.today
  #     update_attributes(status: "expired")
  #   end
  # end

end
