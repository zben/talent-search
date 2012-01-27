# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120121235649) do

  create_table "cities", :force => true do |t|
    t.string   "name_ch"
    t.string   "name_en"
    t.integer  "province_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "educations", :force => true do |t|
    t.integer  "user_id"
    t.string   "school"
    t.string   "school_location"
    t.string   "degree_type"
    t.string   "program"
    t.date     "start_date"
    t.date     "end_date"
    t.float    "GPA"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exams", :force => true do |t|
    t.integer  "user_id"
    t.string   "exam_name"
    t.integer  "score"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "experiences", :force => true do |t|
    t.integer  "user_id"
    t.string   "company_name"
    t.string   "company_location"
    t.string   "job_title"
    t.text     "description"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "industries", :force => true do |t|
    t.string   "name_ch"
    t.string   "name_en"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "industries_users", :id => false, :force => true do |t|
    t.integer "industry_id"
    t.integer "user_id"
    t.integer "interest_id"
  end

  add_index "industries_users", ["industry_id", "user_id"], :name => "index_industries_users_on_industry_id_and_user_id"
  add_index "industries_users", ["user_id", "industry_id"], :name => "index_industries_users_on_user_id_and_industry_id"

  create_table "interests", :force => true do |t|
    t.string   "name_en"
    t.string   "name_ch"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "job_posts", :force => true do |t|
    t.string   "title"
    t.integer  "city_id"
    t.integer  "industry_id"
    t.integer  "years_required"
    t.string   "company_name"
    t.integer  "company_id"
    t.text     "description"
    t.text     "job_requirement"
    t.integer  "job_type_id"
    t.integer  "salary"
    t.date     "expiration"
    t.string   "contact_person"
    t.string   "phone_number"
    t.string   "email"
    t.string   "logo"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "job_posts_skills", :id => false, :force => true do |t|
    t.integer "job_post_id"
    t.integer "skill_id"
  end

  add_index "job_posts_skills", ["job_post_id", "skill_id"], :name => "index_job_posts_skills_on_job_post_id_and_skill_id"
  add_index "job_posts_skills", ["skill_id", "job_post_id"], :name => "index_job_posts_skills_on_skill_id_and_job_post_id"

  create_table "languages", :force => true do |t|
    t.integer  "user_id"
    t.integer  "language_option_id"
    t.integer  "language_level_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organization_profiles", :force => true do |t|
    t.string   "name"
    t.text     "short_description"
    t.text     "long_description"
    t.integer  "location_id"
    t.string   "contact_person"
    t.string   "phone_number"
    t.string   "email"
    t.string   "logo"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "firstname"
    t.string   "lastname"
    t.date     "birthday"
    t.integer  "gender_id"
    t.integer  "citizenship"
    t.integer  "residence_country"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "intro"
    t.string   "intro_title"
    t.integer  "province_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "provinces", :force => true do |t|
    t.string   "name_ch"
    t.string   "name_en"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skill_categories", :force => true do |t|
    t.string   "name_en"
    t.string   "name_ch"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skills", :force => true do |t|
    t.integer  "skill_category_id"
    t.string   "name_en"
    t.string   "name_ch"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skills_users", :id => false, :force => true do |t|
    t.integer  "user_id"
    t.integer  "skill_id"
    t.integer  "skill_level_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "usages", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "find_job"
    t.boolean  "find_project"
    t.boolean  "find_partner"
    t.boolean  "find_money"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "type_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
