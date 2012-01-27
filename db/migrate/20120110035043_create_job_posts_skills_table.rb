class CreateJobPostsSkillsTable < ActiveRecord::Migration
  def up
    create_table :job_posts_skills, :id => false do |t|
        t.references :job_post
        t.references :skill
    end
    add_index :job_posts_skills, [:job_post_id, :skill_id]
    add_index :job_posts_skills, [:skill_id, :job_post_id]

  end

  def down
    drop_table :job_posts_skills

  end
end

