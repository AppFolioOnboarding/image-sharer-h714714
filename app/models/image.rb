require 'uri'
class Image < ApplicationRecord
  validates :image_url, presence: true
  validates_format_of :image_url,
                      with: %r{^(http|https)://[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(/.*)?$}ix, # rubocop:disable Metrics/LineLength
                      multiline: true
  acts_as_taggable
end
