class Resume < ActiveRecord::Base
  has_attached_file :cover,
                    styles: { medium: '300x300>', thumb: '100x100>', micro: '40x40>' },
                    default_url: 'backg.png'
  validates_attachment_content_type :cover, content_type: /\Acover\/.*\Z/

  has_many :schools
 
  belongs_to :location
  belongs_to :user
end
