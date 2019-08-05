require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  def test_empty_url
    empty_url = Image.new
    assert_not empty_url.valid?
  end

  def test_invalid_url
    invalid_url = Image.new(image_url: '123456')
    assert_not invalid_url.valid?
  end

  def test_valid_url
    valid_url = Image.new(image_url: 'http://example.com')
    assert valid_url.valid?
  end

  def test_default_scope
    Image.create!(image_url: 'http://hidden.com', hidden: true)
    non_hidden = Image.create!(image_url: 'http://nonhidden.com', hidden: false)
    assert_equal [non_hidden], Image.all
  end
end
