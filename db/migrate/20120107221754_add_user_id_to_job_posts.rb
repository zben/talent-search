class AddUserIdToJobPosts < ActiveRecord::Migration
  def change
    add_column :job_posts, :user_id, :integer
  end
end
