require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  def test_simple_test
    get root_path
    assert_response :ok
  end

  def test_create_valid_url
    assert_difference 'Image.count', 1 do
      post images_path, params: { 'image' => { 'image_url' => 'http://e.com' } }
    end
  end

  def test_create_invalid_url
    assert_no_difference 'Image.count' do
      post images_path, params: { 'image' => { 'image_url' => '123' } }
    end
  end

end
