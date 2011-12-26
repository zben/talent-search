require 'test_helper'

class ExamTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Exam.new.valid?
  end
end
