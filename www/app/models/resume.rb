class Resume < ActiveRecord::Base
  has_attached_file :cover,
                    styles: { medium: '300x300>', thumb: '100x100>', micro: '40x40>' },
                    default_url: 'backg.png'
  validates_attachment_content_type :cover, content_type: /\Acover\/.*\Z/

  has_many :schools
  has_many :languages
  has_many :skills
  has_many :experiences
  has_many :djrs
  has_many :djis
  has_one :djs
 
  belongs_to :location
  belongs_to :user
  belongs_to :employment_status


  def self.options_for_select
  end

  filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: [
      :sorted_by,
      :search_query,
      :with_location_id,
      :with_employment_status_id,
      :with_employment_count,
      :with_desired_job_salary,
      :with_age,
      :with_desired_job_role
    ]
  )

  self.per_page = 10

  scope :search_query, -> (query) {
    return nil if query.blank?
    terms = query.downcase.split(/\s+/)
    terms = terms.map { |e|
      (e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }

    num_or_conditions = 3

    where(
      terms.map {
        or_clauses = [
          "LOWER(resumes.firstname) LIKE ?",
          "LOWER(resumes.lastname) LIKE ?",
          "LOWER(resumes.phone) LIKE ?",
        ].join(' OR ')
        "(#{ or_clauses })"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conditions }.flatten
    )
  }

  scope :sorted_by, -> (sort_option) {
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^created_at_/
      order("resumes.created_at #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  delegate :salary, to: :djs, prefix: true

  scope :with_location_id, -> (location_ids) {
    location_ids.select! {|ele| ele != ""}
    where(location_id: [*location_ids]) if location_ids.present?
  }

  scope :with_employment_status_id, -> (employment_status_ids) {
    employment_status_ids.select! {|ele| ele != ""}
    where(employment_status_id: [*employment_status_ids]) if employment_status_ids.present?
  }

  scope :with_employment_count, -> (employment_counts) {
    employment_counts.select! {|ele| ele != ""}
    if employment_counts.first == 1
      where(experience_count: 0) if employment_counts.present?
    elsif employment_counts.first == 2
      where(experience_count: 1..2) if employment_counts.present?
    elsif employment_counts.first == 3
      where(experience_count: 3..5) if employment_counts.present?
    elsif employment_counts.first == 4
      where("experience_count: >= 6") if employment_counts.present?
    end
  }

  scope :with_desired_job_salary, -> (desired_job_salaries) {
    desired_job_salaries.select! {|ele| ele != ""}
    if desired_job_salaries.first == 1
      includes(:djs).where(djs: { salary: 0..99999 }) if desired_job_salaries.present?
    elsif desired_job_salaries.first == 2
      includes(:djs).where(djs: { salary: 100000..249999 }) if desired_job_salaries.present?
    elsif desired_job_salaries.first == 3
      includes(:djs).where(djs: { salary: 250000..499999 }) if desired_job_salaries.present?
    elsif desired_job_salaries.first == 4
      includes(:djs).where(djs: { salary: 500000..749999 }) if desired_job_salaries.present?
    elsif desired_job_salaries.first == 5
      includes(:djs).where(djs: { salary: 750000..1000000000 }) if desired_job_salaries.present?
    end
  }

  scope :with_age, -> (ages) {
    ages.select! {|ele| ele != ""}
    if ages.first == 1
      where(birth: 29.year.ago..18.year.ago) if ages.present?
    elsif ages.first == 2
      where(birth: 39.year.ago..29.year.ago) if ages.present?
    elsif ages.first == 3
      where(birth: 49.year.ago..39.year.ago) if ages.present?
    end
  }

  scope :with_desired_job_role, -> (desired_job_roles) {
    desired_job_roles.select! {|ele| ele != ""}
    includes(:djrs).where(djrs: { category_id: [*desired_job_roles] }) if desired_job_roles.present?
  }
  
  def self.options_for_sorted_by
    [
      ['Recently Listed (newest first)', 'created_at_desc'],
      ['Recently Lidted (oldest first)', 'created_at_asc']
    ]
  end

  def age
    (Date.today.year - birth.year).to_s
  end
end

