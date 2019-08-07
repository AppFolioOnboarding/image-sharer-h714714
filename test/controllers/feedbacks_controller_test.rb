require 'test_helper'

class FeedbacksControllerTest < ActionDispatch::IntegrationTest # rubocop:disable Metrics/ClassLength
  def test_simple_test
    get new_feedback_path
    assert_response :ok
  end

  def test_create__valid_feedback
    assert_difference 'Feedback.count', 1 do
      post api_feedbacks_path, params: { 'feedback' => { 'name' => 'my name', 'comment' => 'my comment' } }
      assert_response :ok
    end
  end

  def test_create__invalid_feedback
    assert_no_difference 'Feedback.count' do
      post api_feedbacks_path, params: { 'feedback' => { 'name' => 'my name' } }
      assert_response :bad_request
      post api_feedbacks_path, params: { 'feedback' => { 'comment' => 'my comment' } }
      assert_response :bad_request
    end
  end
end
