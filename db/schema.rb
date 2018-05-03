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

ActiveRecord::Schema.define(version: 2018_05_03_175447) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", id: :serial, force: :cascade do |t|
    t.text "body"
    t.integer "author_id"
    t.integer "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "anonymous", default: false
    t.index ["author_id"], name: "index_answers_on_author_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "categories", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "permalink"
    t.index ["permalink"], name: "index_categories_on_permalink"
  end

  create_table "questions", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category_id"
    t.integer "views", default: 0
    t.boolean "anonymous", default: false
    t.integer "answers_count", default: 0
    t.string "permalink"
    t.boolean "closed", default: false, null: false
    t.index ["author_id"], name: "index_questions_on_author_id"
    t.index ["category_id"], name: "index_questions_on_category_id"
    t.index ["permalink"], name: "index_questions_on_permalink"
  end

  create_table "rs_evaluations", id: :serial, force: :cascade do |t|
    t.string "reputation_name"
    t.integer "source_id"
    t.string "source_type"
    t.integer "target_id"
    t.string "target_type"
    t.float "value", default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "data"
    t.index ["reputation_name", "source_id", "source_type", "target_id", "target_type"], name: "index_rs_evaluations_on_reputation_name_and_source_and_target", unique: true
    t.index ["reputation_name"], name: "index_rs_evaluations_on_reputation_name"
    t.index ["source_id", "source_type"], name: "index_rs_evaluations_on_source_id_and_source_type"
    t.index ["target_id", "target_type"], name: "index_rs_evaluations_on_target_id_and_target_type"
  end

  create_table "rs_reputation_messages", id: :serial, force: :cascade do |t|
    t.integer "sender_id"
    t.string "sender_type"
    t.integer "receiver_id"
    t.float "weight", default: 1.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["receiver_id", "sender_id", "sender_type"], name: "index_rs_reputation_messages_on_receiver_id_and_sender", unique: true
    t.index ["receiver_id"], name: "index_rs_reputation_messages_on_receiver_id"
    t.index ["sender_id", "sender_type"], name: "index_rs_reputation_messages_on_sender_id_and_sender_type"
  end

  create_table "rs_reputations", id: :serial, force: :cascade do |t|
    t.string "reputation_name"
    t.float "value", default: 0.0
    t.string "aggregated_by"
    t.integer "target_id"
    t.string "target_type"
    t.boolean "active", default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "data"
    t.index ["reputation_name", "target_id", "target_type"], name: "index_rs_reputations_on_reputation_name_and_target", unique: true
    t.index ["reputation_name"], name: "index_rs_reputations_on_reputation_name"
    t.index ["target_id", "target_type"], name: "index_rs_reputations_on_target_id_and_target_type"
  end

  create_table "subscriptions", id: :serial, force: :cascade do |t|
    t.integer "subscribable_id"
    t.string "subscribable_type"
    t.integer "subscriber_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subscribable_id", "subscribable_type"], name: "index_subscriptions_on_subscribable_id_and_subscribable_type"
    t.index ["subscriber_id"], name: "index_subscriptions_on_subscriber_id"
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.integer "taggable_id"
    t.string "taggable_type"
    t.integer "tagger_id"
    t.string "tagger_type"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "username"
    t.string "fullname"
    t.text "bio"
    t.string "avatar"
    t.integer "role", default: 0
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role"], name: "index_users_on_role"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
