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
end
