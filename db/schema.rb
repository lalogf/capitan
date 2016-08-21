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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160820074109) do

  create_table "answers", force: :cascade do |t|
    t.integer  "page_id",    limit: 4
    t.integer  "user_id",    limit: 4
    t.text     "result",     limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "points",     limit: 4
  end

  add_index "answers", ["page_id"], name: "index_answers_on_page_id", using: :btree
  add_index "answers", ["user_id"], name: "index_answers_on_user_id", using: :btree

  create_table "authentication_providers", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "authentication_providers", ["name"], name: "index_name_on_authentication_providers", using: :btree

  create_table "branches", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "code",       limit: 255
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id",           limit: 4
    t.integer  "holder_id",         limit: 4
    t.integer  "commentable_id",    limit: 4
    t.string   "commentable_type",  limit: 255
    t.string   "commentable_url",   limit: 255
    t.string   "commentable_title", limit: 255
    t.string   "commentable_state", limit: 255
    t.string   "anchor",            limit: 255
    t.string   "title",             limit: 255
    t.string   "contacts",          limit: 255
    t.text     "raw_content",       limit: 65535
    t.text     "content",           limit: 65535
    t.string   "view_token",        limit: 255
    t.string   "state",             limit: 255,   default: "draft"
    t.string   "ip",                limit: 255,   default: "undefined"
    t.string   "referer",           limit: 255,   default: "undefined"
    t.string   "user_agent",        limit: 255,   default: "undefined"
    t.integer  "tolerance_time",    limit: 4
    t.boolean  "spam",              limit: 1,     default: false
    t.integer  "parent_id",         limit: 4
    t.integer  "lft",               limit: 4
    t.integer  "rgt",               limit: 4
    t.integer  "depth",             limit: 4,     default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", force: :cascade do |t|
    t.string   "name",                          limit: 255
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.text     "description",                   limit: 65535
    t.string   "avatar_file_name",              limit: 255
    t.string   "avatar_content_type",           limit: 255
    t.integer  "avatar_file_size",              limit: 4
    t.datetime "avatar_updated_at"
    t.string   "color",                         limit: 255
    t.string   "background_image_file_name",    limit: 255
    t.string   "background_image_content_type", limit: 255
    t.integer  "background_image_file_size",    limit: 4
    t.datetime "background_image_updated_at"
    t.string   "code",                          limit: 255
    t.integer  "points",                        limit: 4
    t.integer  "track_id",                      limit: 4
    t.string   "course_plan",                   limit: 255
  end

  add_index "courses", ["track_id"], name: "index_courses_on_track_id", using: :btree

  create_table "enrollments", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "course_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.boolean  "status",     limit: 1
  end

  add_index "enrollments", ["course_id"], name: "index_enrollments_on_course_id", using: :btree
  add_index "enrollments", ["user_id"], name: "index_enrollments_on_user_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.integer  "branch_id",   limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "groups", ["branch_id"], name: "index_groups_on_branch_id", using: :btree

  create_table "lessons", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.integer  "unit_id",     limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "sequence",    limit: 4,   default: 0
    t.integer  "points",      limit: 4
    t.string   "lesson_plan", limit: 255
  end

  add_index "lessons", ["unit_id"], name: "index_lessons_on_unit_id", using: :btree

  create_table "options", force: :cascade do |t|
    t.string   "description", limit: 255
    t.integer  "question_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.boolean  "correct",     limit: 1
  end

  add_index "options", ["question_id"], name: "index_options_on_question_id", using: :btree

  create_table "page_visibilities", force: :cascade do |t|
    t.integer  "page_id",    limit: 4
    t.integer  "branch_id",  limit: 4
    t.boolean  "status",     limit: 1
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "page_visibilities", ["branch_id"], name: "index_page_visibilities_on_branch_id", using: :btree
  add_index "page_visibilities", ["page_id"], name: "index_page_visibilities_on_page_id", using: :btree

  create_table "pages", force: :cascade do |t|
    t.string   "title",                      limit: 255
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.string   "page_type",                  limit: 255
    t.integer  "sequence",                   limit: 4
    t.text     "instructions",               limit: 65535
    t.text     "html",                       limit: 65535
    t.text     "initial_state",              limit: 65535
    t.text     "solution",                   limit: 65535
    t.string   "success_message",            limit: 255
    t.string   "videotip",                   limit: 255
    t.integer  "points",                     limit: 4
    t.integer  "question_points",            limit: 4
    t.boolean  "selfLearning",               limit: 1,     default: false
    t.boolean  "load_from_previous",         limit: 1
    t.boolean  "auto_corrector",             limit: 1,     default: false
    t.integer  "grade",                      limit: 4,     default: 0
    t.string   "slide_url",                  limit: 255
    t.string   "document_file_name",         limit: 255
    t.string   "document_content_type",      limit: 255
    t.integer  "document_file_size",         limit: 4
    t.datetime "document_updated_at"
    t.text     "excercise_instructions",     limit: 65535
    t.string   "video_solution",             limit: 255
    t.string   "solution_file_file_name",    limit: 255
    t.string   "solution_file_content_type", limit: 255
    t.integer  "solution_file_file_size",    limit: 4
    t.datetime "solution_file_updated_at"
    t.integer  "draft_comments_count",       limit: 4,     default: 0
    t.integer  "published_comments_count",   limit: 4,     default: 0
    t.integer  "deleted_comments_count",     limit: 4,     default: 0
    t.string   "solution_visibility",        limit: 255
    t.integer  "lesson_id",                  limit: 4
    t.string   "material_type",              limit: 255
    t.string   "quiz_url",                   limit: 255
    t.boolean  "show_title",                 limit: 1,     default: true
    t.string   "video_url",                  limit: 255
  end

  add_index "pages", ["lesson_id"], name: "index_pages_on_lesson_id", using: :btree

  create_table "question_groups", force: :cascade do |t|
    t.integer  "page_id",     limit: 4
    t.integer  "question_id", limit: 4
    t.integer  "sequence",    limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "question_groups", ["page_id"], name: "index_question_groups_on_page_id", using: :btree
  add_index "question_groups", ["question_id"], name: "index_question_groups_on_question_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "page_id",     limit: 4
    t.integer  "question_id", limit: 4
    t.text     "answer",      limit: 65535
    t.integer  "user_id",     limit: 4
    t.integer  "reviewer_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "reviews", ["page_id"], name: "index_reviews_on_page_id", using: :btree
  add_index "reviews", ["question_id"], name: "index_reviews_on_question_id", using: :btree

  create_table "sprint_summaries", force: :cascade do |t|
    t.integer  "user_id",                limit: 4
    t.integer  "sprint_id",              limit: 4
    t.float    "total_technical_skills", limit: 24
    t.float    "total_soft_skills",      limit: 24
    t.float    "max_technical_skills",   limit: 24
    t.float    "max_soft_skills",        limit: 24
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "sprint_summaries", ["user_id"], name: "index_sprint_summaries_on_user_id", using: :btree

  create_table "submissions", force: :cascade do |t|
    t.integer  "page_id",    limit: 4
    t.integer  "user_id",    limit: 4
    t.string   "link",       limit: 255
    t.integer  "points",     limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "submissions", ["page_id"], name: "index_submissions_on_page_id", using: :btree
  add_index "submissions", ["user_id"], name: "index_submissions_on_user_id", using: :btree

  create_table "tracks", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "description", limit: 255
    t.string   "syllabus",    limit: 255
  end

  create_table "units", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.string   "description", limit: 255
    t.integer  "course_id",   limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "sequence",    limit: 4,   default: 0
    t.integer  "points",      limit: 4
    t.integer  "duration",    limit: 4
  end

  add_index "units", ["course_id"], name: "index_units_on_course_id", using: :btree

  create_table "user_authentications", force: :cascade do |t|
    t.integer  "user_id",                    limit: 4
    t.integer  "authentication_provider_id", limit: 4
    t.string   "uid",                        limit: 255
    t.string   "token",                      limit: 255
    t.datetime "token_expires_at"
    t.text     "params",                     limit: 65535
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "user_authentications", ["authentication_provider_id"], name: "index_user_authentications_on_authentication_provider_id", using: :btree
  add_index "user_authentications", ["user_id"], name: "index_user_authentications_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                       limit: 255, default: ""
    t.string   "encrypted_password",          limit: 255, default: "",    null: false
    t.string   "reset_password_token",        limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",               limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",          limit: 255
    t.string   "last_sign_in_ip",             limit: 255
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.string   "provider",                    limit: 255
    t.string   "uid",                         limit: 255
    t.string   "dni",                         limit: 255
    t.string   "code",                        limit: 255
    t.string   "name",                        limit: 255,                 null: false
    t.string   "lastname1",                   limit: 255,                 null: false
    t.string   "lastname2",                   limit: 255
    t.integer  "age",                         limit: 4
    t.string   "district",                    limit: 255
    t.string   "facebook_username",           limit: 255
    t.string   "phone1",                      limit: 255
    t.string   "phone2",                      limit: 255
    t.integer  "branch_id",                   limit: 4
    t.boolean  "disable",                     limit: 1,   default: false
    t.integer  "my_draft_comments_count",     limit: 4,   default: 0
    t.integer  "my_published_comments_count", limit: 4,   default: 0
    t.integer  "my_comments_count",           limit: 4,   default: 0
    t.integer  "draft_comcoms_count",         limit: 4,   default: 0
    t.integer  "published_comcoms_count",     limit: 4,   default: 0
    t.integer  "deleted_comcoms_count",       limit: 4,   default: 0
    t.integer  "spam_comcoms_count",          limit: 4,   default: 0
    t.integer  "roles_mask",                  limit: 4
    t.string   "avatar_file_name",            limit: 255
    t.string   "avatar_content_type",         limit: 255
    t.integer  "avatar_file_size",            limit: 4
    t.datetime "avatar_updated_at"
    t.integer  "role",                        limit: 4,   default: 0
  end

  add_index "users", ["branch_id"], name: "index_users_on_branch_id", using: :btree
  add_index "users", ["code"], name: "index_users_on_code", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "answers", "pages"
  add_foreign_key "answers", "users"
  add_foreign_key "courses", "tracks"
  add_foreign_key "enrollments", "courses"
  add_foreign_key "enrollments", "users"
  add_foreign_key "groups", "branches"
  add_foreign_key "lessons", "units"
  add_foreign_key "options", "questions"
  add_foreign_key "page_visibilities", "branches"
  add_foreign_key "page_visibilities", "pages"
  add_foreign_key "pages", "lessons"
  add_foreign_key "question_groups", "pages"
  add_foreign_key "question_groups", "questions"
  add_foreign_key "units", "courses"
  add_foreign_key "users", "branches"
end
