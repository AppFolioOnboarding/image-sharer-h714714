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

  def test_show_views
    image = Image.create!(image_url: 'https://tineye.com/images/widgets/mona.jpg')
    get image_path(image.id)
    assert_response :ok

    assert_select 'img' do
      assert_select '[src=?]', 'https://tineye.com/images/widgets/mona.jpg'
    end
  end

  def test_index_action
    image_urls = %w[http://oi64.tinypic.com/2eamloy.jpg
                    http://oi67.tinypic.com/2mg9fs8.jpg
                    https://tineye.com/images/widgets/mona.jpg]
    Image.create!(image_url: 'https://tineye.com/images/widgets/mona.jpg')
    Image.create!(image_url: 'http://oi67.tinypic.com/2mg9fs8.jpg')
    Image.create!(image_url: 'http://oi64.tinypic.com/2eamloy.jpg')
    get images_path
    assert_response :ok

    assert_select 'img' do |elements|
      elements.each_with_index do |element, index|
        assert_equal element[:src], image_urls[index]
        assert_equal element[:width], '400'
      end
    end
  end
end
