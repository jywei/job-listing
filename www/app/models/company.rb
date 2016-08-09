class Company < ActiveRecord::Base
  has_attached_file :image,
                    styles: { medium: "300x300>", thumb: "100x100>", micro: "40x40>" },
                    default_url: "nia.png"

  has_attached_file :cover,
                    styles: { cover: "700x300>", preview: "230x100>" },
                    default_url: "backg.png"

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_attachment_content_type :cover, content_type: /\Acover\/.*\Z/
end
