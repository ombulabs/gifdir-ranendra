class Image < ApplicationRecord
  belongs_to :user
  validates :name, presence: true

  has_one_attached :gif_file
  validates :gif_file, content_type: 'image/gif',  
    size: { less_than: 1.megabytes , message: 'should be less than one megabyte.' }
end
