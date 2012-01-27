class SkillsUsers < ActiveRecord::Migration
    def self.up
        create_table :skills_users, :id => false, :force => true do |t|
            t.integer :user_id
            t.integer :skill_id
            t.integer :skill_level_id
            t.text :comment
            t.timestamps
        end
    end
 
    def self.down
        drop_table :skills_users
    end
end
