class Picture < ActiveRecord::Base

  belongs_to :imageable, polymorphic: true

  has_attached_file :image, styles: { thumb: "250x250>" },
                    :default_url => "https://s3.amazonaws.com/unravaled_dev/default_images/unraveled_default.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\z/

end