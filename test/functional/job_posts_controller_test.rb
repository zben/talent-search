require 'test_helper'

class JobPostsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => JobPost.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    JobPost.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    JobPost.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to job_post_url(assigns(:job_post))
  end

  def test_edit
    get :edit, :id => JobPost.first
    assert_template 'edit'
  end

  def test_update_invalid
    JobPost.any_instance.stubs(:valid?).returns(false)
    put :update, :id => JobPost.first
    assert_template 'edit'
  end

  def test_update_valid
    JobPost.any_instance.stubs(:valid?).returns(true)
    put :update, :id => JobPost.first
    assert_redirected_to job_post_url(assigns(:job_post))
  end

  def test_destroy
    job_post = JobPost.first
    delete :destroy, :id => job_post
    assert_redirected_to job_posts_url
    assert !JobPost.exists?(job_post.id)
  end
end
