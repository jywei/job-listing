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

  filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: [
      :sorted_by,
      :search_query,
      :with_category_id,
      :with_industry_id,
      :with_created_at_gte
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
    when /^created_at_/
      order("jobs.created_at #{ direction }")
    when /^title_/
      order("LOWER(jobs.title) #{ direction }")
    when /^industry_name_/
      order("LOWER(industries.name) #{ direction }").includes(:industry)
    when /^category_name_/
      order("LOWER(categories.name) #{ direction }").includes(:category)
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  scope :with_industry_id, -> (industry_ids) {
    industry_ids.select! {|ele| ele != ""}
    unless industry_ids.empty?
      where(industry_id: [*industry_ids])
    end
  }

  scope :with_category_id, -> (category_ids) {
    category_ids.select! {|ele| ele != ""}
    unless category_ids.empty?
      where(category_id: [*category_ids])
    end
  }

  scope :with_created_at_gte, -> (ref_date) {
    where('jobs.created_at >= ?', ref_date)
  }

  delegate :name, to: :industry, prefix: true

  delegate :name, to: :category, prefix: true

  def self.options_for_sorted_by
    [
      ['Title (a-z)', 'title_asc'],
      ['Creation date (newest first)', 'created_at_desc'],
      ['Creation date (oldest first)', 'created_at_asc'],
      ['Industry (a-z)', 'industry_name_asc'],
      ['Category (a-z)', 'category_name_asc']
    ]
  end

  def decorated_created_at
    created_at.to_date.to_s(:long)
  end

end
