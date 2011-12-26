require 'test_helper'

class EducationTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Education.new.valid?
  end
end
