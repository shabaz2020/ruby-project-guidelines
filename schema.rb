
ActiveRecord::Schema.define(version: 20180103162053) do

  create_table "authors", force: :cascade do |r|
    r.string "name"
    r.string "goodreads_id"
    r.string "goodreads_url"
  end

  create_table "books", force: :cascade do |r|
    r.string  "title"
    r.integer "genre_id"
    r.integer "author_id"
    t.integer "published_date"
    t.string  "goodreads_id"
    t.string  "goodreads_url"
    t.string  "isbn"
    t.integer "page_count"
    t.string  "publisher"
    t.float   "average_rating"
    t.integer "ratings_count"
    t.text    "description"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "rating"
    t.string   "content"
    t.datetime "reviewed_date"
    t.integer  "book_id"
    t.integer  "user_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "goodreads_user_id"
    t.string "goodreads_user_url"
  end

end
