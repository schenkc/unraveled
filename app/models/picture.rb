class Picture < ActiveRecord::Base

  belongs_to :imageable, polymorphic: true

  has_attached_file :image, styles: { thumb: "250x250>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\z/

end