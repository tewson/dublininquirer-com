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

ActiveRecord::Schema.define(version: 2019_02_05_210617) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "articles", force: :cascade do |t|
    t.text "title", null: false
    t.text "slug", null: false
    t.text "excerpt"
    t.text "content"
    t.text "text"
    t.bigint "author_ids", default: [], array: true
    t.datetime "published_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "featured_artwork_id"
    t.text "status"
    t.bigint "wp_id"
    t.text "former_slugs", default: [], array: true
    t.text "categories", default: [], array: true
    t.text "template"
    t.boolean "featured", default: false
    t.text "category"
    t.bigint "issue_id"
    t.integer "position"
    t.jsonb "structured_content", default: []
    t.bigint "tag_ids", default: [], array: true
    t.index ["author_ids"], name: "index_articles_on_author_ids"
    t.index ["categories"], name: "index_articles_on_categories"
    t.index ["category"], name: "index_articles_on_category"
    t.index ["featured_artwork_id"], name: "index_articles_on_featured_artwork_id"
    t.index ["former_slugs"], name: "index_articles_on_former_slugs"
    t.index ["issue_id"], name: "index_articles_on_issue_id"
    t.index ["position"], name: "index_articles_on_position"
    t.index ["published_at"], name: "index_articles_on_published_at"
    t.index ["slug"], name: "index_articles_on_slug", unique: true
    t.index ["status"], name: "index_articles_on_status"
    t.index ["tag_ids"], name: "index_articles_on_tag_ids"
    t.index ["wp_id"], name: "index_articles_on_wp_id"
  end

  create_table "artworks", force: :cascade do |t|
    t.text "caption"
    t.text "image"
    t.text "hashed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "wp_id"
    t.text "wp_file"
    t.bigint "article_id"
    t.integer "width_px"
    t.integer "height_px"
    t.index ["article_id"], name: "index_artworks_on_article_id"
    t.index ["hashed_id"], name: "index_artworks_on_hashed_id", unique: true
    t.index ["wp_file"], name: "index_artworks_on_wp_file", unique: true
    t.index ["wp_id"], name: "index_artworks_on_wp_id"
  end

  create_table "authors", force: :cascade do |t|
    t.text "full_name", null: false
    t.text "slug", null: false
    t.text "bio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "portrait"
    t.bigint "wp_id"
    t.index ["slug"], name: "index_authors_on_slug", unique: true
    t.index ["wp_id"], name: "index_authors_on_wp_id"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "article_id"
    t.bigint "parent_id"
    t.text "wp_id"
    t.text "content"
    t.text "nickname"
    t.text "email_address"
    t.text "status"
    t.datetime "published_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "marked_as_spam", default: false
    t.index ["article_id"], name: "index_comments_on_article_id"
    t.index ["email_address"], name: "index_comments_on_email_address"
    t.index ["marked_as_spam"], name: "index_comments_on_marked_as_spam"
    t.index ["parent_id"], name: "index_comments_on_parent_id"
    t.index ["status"], name: "index_comments_on_status"
    t.index ["user_id"], name: "index_comments_on_user_id"
    t.index ["wp_id"], name: "index_comments_on_wp_id"
  end

  create_table "gift_subscriptions", force: :cascade do |t|
    t.bigint "subscription_id"
    t.bigint "plan_id"
    t.integer "duration"
    t.text "giver_given_name"
    t.text "giver_surname"
    t.text "giver_email_address"
    t.text "first_address_line_1"
    t.text "first_address_line_2"
    t.text "first_city"
    t.text "first_county"
    t.text "first_post_code"
    t.text "first_country_code"
    t.text "notes"
    t.text "redemption_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "stripe_id"
    t.datetime "charged_at"
    t.index ["charged_at"], name: "index_gift_subscriptions_on_charged_at"
    t.index ["plan_id"], name: "index_gift_subscriptions_on_plan_id"
    t.index ["redemption_code"], name: "index_gift_subscriptions_on_redemption_code", unique: true
    t.index ["stripe_id"], name: "index_gift_subscriptions_on_stripe_id", unique: true
    t.index ["subscription_id"], name: "index_gift_subscriptions_on_subscription_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.text "stripe_id"
    t.text "number"
    t.text "receipt_number"
    t.integer "total"
    t.boolean "closed"
    t.boolean "paid"
    t.boolean "attempted"
    t.boolean "forgiven"
    t.date "created_on"
    t.date "due_on"
    t.datetime "period_starts_at"
    t.datetime "period_ends_at"
    t.datetime "next_payment_attempt_at"
    t.jsonb "lines", default: {}
    t.bigint "user_id"
    t.bigint "subscription_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_on"], name: "index_invoices_on_created_on"
    t.index ["due_on"], name: "index_invoices_on_due_on"
    t.index ["number"], name: "index_invoices_on_number"
    t.index ["receipt_number"], name: "index_invoices_on_receipt_number"
    t.index ["stripe_id"], name: "index_invoices_on_stripe_id", unique: true
    t.index ["subscription_id"], name: "index_invoices_on_subscription_id"
    t.index ["user_id"], name: "index_invoices_on_user_id"
  end

  create_table "issues", force: :cascade do |t|
    t.date "issue_date"
    t.boolean "published", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["issue_date"], name: "index_issues_on_issue_date", unique: true
    t.index ["published"], name: "index_issues_on_published"
  end

  create_table "landing_pages", force: :cascade do |t|
    t.text "name"
    t.text "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_landing_pages_on_slug", unique: true
  end

  create_table "plans", force: :cascade do |t|
    t.text "stripe_id"
    t.integer "amount"
    t.text "interval"
    t.integer "interval_count"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_plans_on_product_id"
    t.index ["stripe_id"], name: "index_plans_on_stripe_id", unique: true
  end

  create_table "products", force: :cascade do |t|
    t.text "name"
    t.text "stripe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "base_price", default: 0
    t.index ["stripe_id"], name: "index_products_on_stripe_id", unique: true
  end

  create_table "subscriptions", force: :cascade do |t|
    t.text "stripe_id"
    t.bigint "plan_id"
    t.bigint "user_id"
    t.datetime "current_period_ends_at"
    t.text "status"
    t.jsonb "metadata"
    t.datetime "canceled_at"
    t.datetime "ended_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "subscription_type", default: "stripe"
    t.boolean "cancel_at_period_end"
    t.bigint "product_id"
    t.datetime "trial_ends_at"
    t.text "landing_page_slug"
    t.index ["current_period_ends_at"], name: "index_subscriptions_on_current_period_ends_at"
    t.index ["landing_page_slug"], name: "index_subscriptions_on_landing_page_slug"
    t.index ["plan_id"], name: "index_subscriptions_on_plan_id"
    t.index ["product_id"], name: "index_subscriptions_on_product_id"
    t.index ["status"], name: "index_subscriptions_on_status"
    t.index ["stripe_id"], name: "index_subscriptions_on_stripe_id", unique: true
    t.index ["subscription_type"], name: "index_subscriptions_on_subscription_type"
    t.index ["trial_ends_at"], name: "index_subscriptions_on_trial_ends_at"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.text "name"
    t.text "slug"
    t.boolean "displayable", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
    t.index ["slug"], name: "index_tags_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.text "email_address", null: false
    t.text "crypted_password"
    t.text "salt"
    t.text "given_name"
    t.text "surname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.text "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.text "nickname"
    t.text "portrait"
    t.text "stripe_id"
    t.datetime "set_password_at"
    t.boolean "subscribed_weekly", default: false
    t.string "role", default: "user"
    t.text "address_line_1"
    t.text "address_line_2"
    t.text "city"
    t.text "county"
    t.text "post_code"
    t.text "country"
    t.text "country_code"
    t.jsonb "metadata"
    t.text "hub"
    t.datetime "banned_at"
    t.index ["banned_at"], name: "index_users_on_banned_at"
    t.index ["city"], name: "index_users_on_city"
    t.index ["country_code"], name: "index_users_on_country_code"
    t.index ["county"], name: "index_users_on_county"
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
    t.index ["hub"], name: "index_users_on_hub"
    t.index ["nickname"], name: "index_users_on_nickname"
    t.index ["post_code"], name: "index_users_on_post_code"
    t.index ["remember_me_token"], name: "index_users_on_remember_me_token"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
    t.index ["role"], name: "index_users_on_role"
    t.index ["stripe_id"], name: "index_users_on_stripe_id", unique: true
  end

  create_table "visitors", force: :cascade do |t|
    t.json "viewed_articles", default: {}
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_visitors_on_user_id"
  end

  add_foreign_key "articles", "artworks", column: "featured_artwork_id"
  add_foreign_key "articles", "issues"
  add_foreign_key "artworks", "articles"
  add_foreign_key "comments", "articles"
  add_foreign_key "comments", "users"
  add_foreign_key "gift_subscriptions", "subscriptions"
  add_foreign_key "invoices", "subscriptions"
  add_foreign_key "invoices", "users"
  add_foreign_key "plans", "products"
  add_foreign_key "subscriptions", "plans"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "visitors", "users"
end
