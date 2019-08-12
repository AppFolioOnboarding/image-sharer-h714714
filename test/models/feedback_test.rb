require 'test_helper'

class FeedbackTest < ActiveSupport::TestCase
  def test_feedback
    valid_feedback = Feedback.new(name: 'my name', comment: 'my comment')
    assert valid_feedback.valid?
  end

  def test_feedback__invalid_name
    empty_name = Feedback.new(comment: 'my comment')
    assert_not empty_name.valid?
  end

  def test_feedback__invalid_comment
    empty_comment = Feedback.new(name: 'my name')
    assert_not empty_comment.valid?
  end
end
