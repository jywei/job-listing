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

  def self.options_for_select
  end

  filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: [
      :sorted_by,
      :search_query,
    ]
  )

  self.per_page = 10

  scope :search_query, -> (query) {
    return nil if query.blank?
    terms = query.downcase.split(/\s+/)
    terms = terms.map { |e|
      (e.gsub('*', '%') + '%')gsub(/%+/, '%')
    }

    number_or_conditions = 6

    where(
      terms.map {
        or_clauses = [
          "LOWER(resumes.first) LIKE ?",
          "LOWER(resumes.phone) LIKE ?"
        ].join(' OR ')
        "(#{ or_clauses })"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conditions }.flatten
    )
  }
end
