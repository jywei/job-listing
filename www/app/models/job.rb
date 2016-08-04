class Job < ActiveRecord::Base
  belongs_to :category, counter_cache: :jobs_count
  belongs_to :industry, counter_cache: :jobs_count
  belongs_to :contract_type, counter_cache: :jobs_count
  belongs_to :location, counter_cache: :jobs_count

  scope :published, -> { where(is_published: true) }

  def self.by_category_and_industry(category_id = nil, industry_id = nil)
    return where(category_id: category_id, industry_id: industry_id) if category_id && industry_id
    return where(category_id: category_id) if category_id
    return where(industry_id: industry_id) if industry_id
    all
  end

  filterrific(
    default_filter_params: { sorted_by: 'start_day_desc' },
    available_filters: [
      :sorted_by,
      :search_query,
      :with_category_id,
      :with_industry_id,
      :with_contract_type_id,
      :with_location_id,
      :with_posted_at_gte
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
    num_or_conditions = 3
    where(
      terms.map {
        or_clauses = [
          "LOWER(jobs.title) LIKE ?",
          "LOWER(jobs.description) LIKE ?",
          "LOWER(jobs.requirement) LIKE ?"
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
    when /^start_day_/
      order("jobs.start_day #{ direction }")
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

  scope :with_posted_at_gte, -> (date) {
    where('start_day >= ?', date)
  }

  delegate :name, to: :industry, prefix: true

  delegate :name, to: :category, prefix: true

  delegate :name, to: :contract_type, prefix: true

  delegate :name, to: :location, prefix: true

  def self.options_for_sorted_by
    [
      ['Title (a-z)', 'title_asc'],
      ['Recently Published (newest first)', 'start_day_desc'],
      ['Recently Published (oldest first)', 'start_day_asc']
    ]
  end

  def decorated_created_at
    created_at.to_date.to_s(:long)
  end

  def decorated_start_day
    start_day.to_s(:long)
  end

end
