require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest # rubocop:disable Metrics/ClassLength
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

  def test_homepage
    get root_path
    assert_response :ok

    assert_select 'a[href=?]', new_image_path
  end

  def test_create_valid_url_tag
    assert_difference 'Image.count', 3 do
      post images_path, params: { 'image' => { 'image_url' => 'http://a.com', 'tag_list' => 'a' } }
      post images_path, params: { 'image' => { 'image_url' => 'http://efg.com', 'tag_list' => 'e, f, g' } }
      post images_path, params: { 'image' => { 'image_url' => 'http://empty.com' } }
      assert_equal Image.last(3)[0].tag_list, %w[a]
      assert_equal Image.last(3)[1].tag_list, %w[e f g]
      assert_equal Image.last(3)[2].tag_list, []
    end
  end

  def test_index_with_tag
    image_urls = %w[http://oi64.tinypic.com/2eamloy.jpg
                    http://oi67.tinypic.com/2mg9fs8.jpg
                    https://tineye.com/images/widgets/mona.jpg]
    image_tags = %w[a b c]
    Image.create!(image_url: 'https://tineye.com/images/widgets/mona.jpg', tag_list: 'c')
    Image.create!(image_url: 'http://oi67.tinypic.com/2mg9fs8.jpg', tag_list: 'b')
    Image.create!(image_url: 'http://oi64.tinypic.com/2eamloy.jpg', tag_list: 'a')
    get images_path
    assert_response :ok

    assert_select 'img' do |elements|
      elements.each_with_index do |element, index|
        assert_equal element[:src], image_urls[index]
        assert_equal element[:width], '400'
      end
    end
    assert_select 'div > a' do |elements|
      elements.each_with_index do |element, index|
        assert_equal images_path(tag_list: image_tags[index]), element[:href]
      end
    end
  end

  def test_show_with_tag
    image_tags = %w[a b c]
    image = Image.create!(image_url: 'http://a.com', tag_list: 'a, b, c')
    get image_path(image.id)

    assert_select 'a' do |elements|
      elements.each_with_index do |element, index|
        assert_equal images_path(tag_list: image_tags[index]), element[:href]
      end
    end
  end

  def test_index_tag_filter
    image_urls = %w[http://a.com http://b.com https://c.com]
    Image.create!(image_url: image_urls[0], tag_list: 'a, b')
    Image.create!(image_url: image_urls[1], tag_list: 'a, c')
    Image.create!(image_url: image_urls[2], tag_list: 'b, c')
    get images_path(tag_list: 'a')

    expected_links = [images_path(tag_list: 'a'),
                      images_path(tag_list: 'c'),
                      images_path(tag_list: 'a'),
                      images_path(tag_list: 'b')]
    assert_response :ok
    assert_select 'div > a', 4
    assert_select 'div > a' do |elements|
      elements.each_with_index do |ele, index|
        assert_equal expected_links[index], ele[:href]
      end
    end
  end

  def test_destroy__image_not_exist
    invalid_id = -1
    assert_no_difference 'Image.count' do
      delete image_path(invalid_id)
      assert_redirected_to images_path
    end
  end

  def test_destroy
    img = Image.create!(image_url: 'http://a.com', tag_list: 'a, c')
    assert_difference 'Image.count', -1 do
      delete image_path(img.id)
      assert_redirected_to images_path
    end
  end
end
