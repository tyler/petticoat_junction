class CreateDefaultSchema < ActiveRecord::Migration
  def self.up
    create_table "refreshes", :force => true do |t|
      t.integer  "term_id"
      t.string   "story_type"
      t.datetime "queued_at"
      t.datetime "searched_at"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "stories", :force => true do |t|
      t.integer  "term_id"
      t.integer  "content_id"
      t.string   "content_type"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.datetime "content_created_at"
    end

    add_index "stories", ["content_created_at"], :name => "index_stories_on_content_created_at"

    create_table "terms", :force => true do |t|
      t.string   "text"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "latest_twitter_id"
      t.datetime "last_viewed_at"
    end

    add_index "terms", ["last_viewed_at"], :name => "index_terms_on_last_viewed_at"
    add_index "terms", ["last_viewed_at"], :name => "index_terms_on_last_viewed_at_and_last_searched_at"

    create_table 'foo_bars', :force => true do |t|
      t.string 'text'
    end
  end

  def self.down
    drop_table :terms
    drop_table :stories
    drop_table :refreshes
    drop_table :foo_bars
  end
end
