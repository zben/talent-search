require 'test_helper'

class OrganizationProfilesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => OrganizationProfile.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    OrganizationProfile.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    OrganizationProfile.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to organization_profile_url(assigns(:organization_profile))
  end

  def test_edit
    get :edit, :id => OrganizationProfile.first
    assert_template 'edit'
  end

  def test_update_invalid
    OrganizationProfile.any_instance.stubs(:valid?).returns(false)
    put :update, :id => OrganizationProfile.first
    assert_template 'edit'
  end

  def test_update_valid
    OrganizationProfile.any_instance.stubs(:valid?).returns(true)
    put :update, :id => OrganizationProfile.first
    assert_redirected_to organization_profile_url(assigns(:organization_profile))
  end

  def test_destroy
    organization_profile = OrganizationProfile.first
    delete :destroy, :id => organization_profile
    assert_redirected_to organization_profiles_url
    assert !OrganizationProfile.exists?(organization_profile.id)
  end
end
