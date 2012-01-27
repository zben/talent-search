require 'test_helper'

class JobPostTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert JobPost.new.valid?
  end
end
