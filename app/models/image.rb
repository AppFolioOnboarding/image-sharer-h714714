require 'uri'
class Image < ApplicationRecord
    validates :image_url, presence: true
    validates_format_of :image_url, :with => URI.regexp
end
