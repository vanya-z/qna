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

ActiveRecord::Schema.define(version: 20150428044704) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: true do |t|
    t.text     "body"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "is_accepted",             default: false
    t.integer  "cached_votes_total",      default: 0
    t.integer  "cached_votes_score",      default: 0
    t.integer  "cached_votes_up",         default: 0
    t.integer  "cached_votes_down",       default: 0
    t.integer  "cached_weighted_score",   default: 0
    t.integer  "cached_weighted_total",   default: 0
    t.float    "cached_weighted_average", default: 0.0
  end

  add_index "answers", ["cached_votes_down"], name: "index_answers_on_cached_votes_down", using: :btree
  add_index "answers", ["cached_votes_score"], name: "index_answers_on_cached_votes_score", using: :btree
  add_index "answers", ["cached_votes_total"], name: "index_answers_on_cached_votes_total", using: :btree
  add_index "answers", ["cached_votes_up"], name: "index_answers_on_cached_votes_up", using: :btree
  add_index "answers", ["cached_weighted_average"], name: "index_answers_on_cached_weighted_average", using: :btree
  add_index "answers", ["cached_weighted_score"], name: "index_answers_on_cached_weighted_score", using: :btree
  add_index "answers", ["cached_weighted_total"], name: "index_answers_on_cached_weighted_total", using: :btree
  add_index "answers", ["question_id"], name: "index_answers_on_question_id", using: :btree
  add_index "answers", ["user_id"], name: "index_answers_on_user_id", using: :btree

  create_table "attachments", force: true do |t|
    t.string   "file"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "attachmentable_id"
    t.string   "attachmentable_type"
  end

  add_index "attachments", ["attachmentable_id"], name: "index_attachments_on_attachmentable_id", using: :btree
  add_index "attachments", ["attachmentable_type"], name: "index_attachments_on_attachmentable_type", using: :btree

  create_table "authorizations", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "confirmation_token"
    t.datetime "confirmation_token_sent_at"
    t.datetime "confirmed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authorizations", ["provider", "uid"], name: "index_authorizations_on_provider_and_uid", using: :btree
  add_index "authorizations", ["user_id"], name: "index_authorizations_on_user_id", using: :btree

  create_table "comments", force: true do |t|
    t.string   "body"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "oauth_access_grants", force: true do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree

  create_table "oauth_access_tokens", force: true do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",             null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        null: false
    t.string   "scopes"
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree

  create_table "oauth_applications", force: true do |t|
    t.string   "name",         null: false
    t.string   "uid",          null: false
    t.string   "secret",       null: false
    t.text     "redirect_uri", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree

  create_table "questions", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "cached_votes_total",      default: 0
    t.integer  "cached_votes_score",      default: 0
    t.integer  "cached_votes_up",         default: 0
    t.integer  "cached_votes_down",       default: 0
    t.integer  "cached_weighted_score",   default: 0
    t.integer  "cached_weighted_total",   default: 0
    t.float    "cached_weighted_average", default: 0.0
    t.integer  "answers_count",           default: 0
  end

  add_index "questions", ["cached_votes_down"], name: "index_questions_on_cached_votes_down", using: :btree
  add_index "questions", ["cached_votes_score"], name: "index_questions_on_cached_votes_score", using: :btree
  add_index "questions", ["cached_votes_total"], name: "index_questions_on_cached_votes_total", using: :btree
  add_index "questions", ["cached_votes_up"], name: "index_questions_on_cached_votes_up", using: :btree
  add_index "questions", ["cached_weighted_average"], name: "index_questions_on_cached_weighted_average", using: :btree
  add_index "questions", ["cached_weighted_score"], name: "index_questions_on_cached_weighted_score", using: :btree
  add_index "questions", ["cached_weighted_total"], name: "index_questions_on_cached_weighted_total", using: :btree
  add_index "questions", ["user_id"], name: "index_questions_on_user_id", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "question_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taggings", ["question_id"], name: "index_taggings_on_question_id", using: :btree
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "taggings_count", default: 0
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,    null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin"
    t.boolean  "password_is_set",        default: true
    t.integer  "questions_count",        default: 0
    t.integer  "answers_count",          default: 0
    t.integer  "reputation",             default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "votes", force: true do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

end
