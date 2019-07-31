require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  def test_simple_test
    get root_path
    assert_response :ok
  end
end
