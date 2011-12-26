require 'test_helper'

class ExperienceTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Experience.new.valid?
  end
end
