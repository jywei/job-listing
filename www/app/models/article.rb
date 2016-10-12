class Article < ActiveRecord::Base
  has_attached_file :cover,
                    # content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] },
                    styles: { medium: "300x300>", thumb: "130x130>", micro: "40x40>" },
                    default_url: "nia.png"

  validates :title,  presence: true
  validates :text,   presence: true
  validates :author, presence: true
  # validates :cover,  attachment_presence: true
  validates_attachment_presence :cover
  validates_attachment_content_type :cover, :content_type => %w(image/jpeg image/jpg image/png)
end
