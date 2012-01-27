require 'test_helper'

class OrganizationProfileTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert OrganizationProfile.new.valid?
  end
end
