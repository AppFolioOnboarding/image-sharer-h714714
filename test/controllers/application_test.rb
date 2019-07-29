require 'test_helper'

class ApplicationTest < ActionDispatch::IntegrationTest
  test 'simple test' do
    get root_path
    assert_response :ok
  end
end
