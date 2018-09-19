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

ActiveRecord::Schema.define(version: 2018_09_19_071843) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admins", force: :cascade do |t|
    t.string "name", null: false
    t.string "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "auths", force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.string "password_digest", null: false
    t.boolean "email_verified"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_auths_on_user_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.bigint "tutor_id"
    t.bigint "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "student_id"
    t.index ["student_id"], name: "index_jobs_on_student_id"
    t.index ["subject_id"], name: "index_jobs_on_subject_id"
    t.index ["tutor_id"], name: "index_jobs_on_tutor_id"
  end

  create_table "requests", force: :cascade do |t|
    t.boolean "status", default: false
    t.bigint "tutor_id"
    t.bigint "student_id"
    t.bigint "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "acceptance", default: false
    t.index ["student_id"], name: "index_requests_on_student_id"
    t.index ["subject_id"], name: "index_requests_on_subject_id"
    t.index ["tutor_id"], name: "index_requests_on_tutor_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "stoken"
    t.boolean "sign_in_status", default: true, null: false
    t.datetime "last_requested_at"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "students", force: :cascade do |t|
    t.integer "price", null: false
    t.datetime "timing"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_students_on_user_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name", null: false
    t.integer "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "approved", default: true
  end

  create_table "subjects_tutors", id: false, force: :cascade do |t|
    t.bigint "subject_id"
    t.bigint "tutor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_subjects_tutors_on_subject_id"
    t.index ["tutor_id"], name: "index_subjects_tutors_on_tutor_id"
  end

  create_table "tutors", force: :cascade do |t|
    t.string "education", null: false
    t.string "experience", null: false
    t.string "availablity", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_tutors_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "info"
    t.integer "user_type", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", null: false
    t.string "username", null: false
    t.string "about"
    t.boolean "gender", null: false
    t.integer "user_status", default: 1
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  create_table "verifications", force: :cascade do |t|
    t.integer "verification_type", null: false
    t.integer "verification_status", default: 0, null: false
    t.string "verification_pin", null: false
    t.boolean "validity"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_verifications_on_user_id"
    t.index ["verification_status"], name: "index_verifications_on_verification_status"
    t.index ["verification_type"], name: "index_verifications_on_verification_type"
  end

  add_foreign_key "auths", "users"
  add_foreign_key "jobs", "students"
  add_foreign_key "jobs", "subjects"
  add_foreign_key "jobs", "tutors"
  add_foreign_key "requests", "students"
  add_foreign_key "requests", "subjects"
  add_foreign_key "requests", "tutors"
  add_foreign_key "sessions", "users"
  add_foreign_key "students", "users"
  add_foreign_key "tutors", "users"
  add_foreign_key "verifications", "users"
end
