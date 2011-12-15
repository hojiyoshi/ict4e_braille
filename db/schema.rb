# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110921143040) do

  create_table "ict4e_master_data", :force => true do |t|
    t.string  "application_name", :limit => 64, :null => false
    t.string  "item_data",        :limit => 64, :null => false
    t.integer "sort_order",                     :null => false
  end

  add_index "ict4e_master_data", ["application_name"], :name => "application_name"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "summary_circles", :force => true do |t|
    t.string   "circle_name",                     :null => false
    t.string   "delegate_name"
    t.string   "circle_url"
    t.datetime "establish_date"
    t.string   "charge_name"
    t.string   "charge_email",     :limit => 100
    t.string   "charge_phone",     :limit => 64
    t.string   "action_area"
    t.text     "circle_introduce"
    t.boolean  "handwriting_flag"
    t.boolean  "pcinputing_flag"
    t.boolean  "netinputing_flag"
    t.boolean  "active_flag",                     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "summary_inputer_attributes", :force => true do |t|
    t.string  "type"
    t.integer "like_id"
    t.integer "dislike_id"
    t.integer "joinday_id"
    t.integer "jointime_id"
    t.integer "summary_user_id", :null => false
  end

  create_table "summary_request_attributes", :id => false, :force => true do |t|
    t.integer "id",                                :null => false
    t.string  "type",               :limit => nil
    t.integer "adapt_id"
    t.integer "summary_request_id"
  end

  create_table "summary_requests", :force => true do |t|
    t.text     "adapt_list_other"
    t.integer  "need_time",         :null => false
    t.string   "request_address"
    t.integer  "request_candinate"
    t.datetime "request_date",      :null => false
    t.integer  "request_circle",    :null => false
    t.string   "request_money"
    t.integer  "request_owner",     :null => false
    t.string   "request_phone"
    t.string   "request_title",     :null => false
    t.integer  "network_env"
    t.text     "network_env_other"
    t.integer  "cordinater_status", :null => false
    t.integer  "inputer_status",    :null => false
    t.integer  "user_status",       :null => false
    t.datetime "reply_limit_date"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "request_type",      :null => false
  end

  create_table "summary_user_circles", :force => true do |t|
    t.integer "summary_circle_id"
    t.integer "summary_user_id"
    t.string  "user_type",         :limit => 1
    t.integer "status",                         :default => 0
  end

  create_table "summary_users", :force => true do |t|
    t.integer "user_id",                                           :null => false
    t.integer "application_type",                                  :null => false
    t.integer "phone_contact",                                     :null => false
    t.string  "skype_id"
    t.integer "inputer_flag",                       :default => 0, :null => false
    t.integer "cordinater_flag",                    :default => 0, :null => false
    t.integer "user_flag",                          :default => 0, :null => false
    t.integer "network_env"
    t.text    "network_env_other"
    t.integer "input_career"
    t.text    "input_career_other"
    t.integer "input_speed"
    t.text    "input_speed_other"
    t.text    "join_day_other"
    t.text    "join_time_other"
    t.text    "like_field_other"
    t.text    "dislike_field_other"
    t.text    "qualification_data"
    t.integer "inputer_status",                     :default => 0
    t.string  "name_kanji",          :limit => 64
    t.string  "name_kana",           :limit => 64
    t.string  "phone_number",        :limit => 64
    t.string  "fax_number",          :limit => 64
    t.string  "cellphone_number",    :limit => 64
    t.string  "cellphone_email",     :limit => 128
  end

  add_index "summary_users", ["user_id"], :name => "summary_users_user_id_key", :unique => true

  create_table "tenji_autodeletes", :force => true do |t|
    t.string "days"
  end

  create_table "tenji_requests", :force => true do |t|
    t.string   "from_zip_code",         :limit => 64, :null => false
    t.string   "from_user_name",        :limit => 64, :null => false
    t.string   "from_user_affiliation", :limit => 64
    t.string   "from_phone_number",     :limit => 64
    t.string   "from_user_address1",                  :null => false
    t.string   "from_user_address2"
    t.string   "to_zip_code",           :limit => 64, :null => false
    t.string   "to_user_name",          :limit => 64, :null => false
    t.string   "to_user_address1",                    :null => false
    t.string   "to_user_address2"
    t.integer  "user_id",                             :null => false
    t.string   "print_name1",                         :null => false
    t.string   "print_title1"
    t.string   "print_title2"
    t.string   "print_title3"
    t.text     "print_contents1"
    t.text     "print_contents2"
    t.text     "print_contents3"
    t.string   "braille_datafile1"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "data_type",             :limit => 32, :null => false
    t.string   "braille_datafile2"
    t.string   "braille_datafile3"
    t.string   "print_name2"
    t.string   "print_name3"
  end

  create_table "tenji_users", :force => true do |t|
    t.integer  "user_id",                                         :null => false
    t.string   "tenji_type",       :limit => 1,  :default => "f", :null => false
    t.string   "zip_code",         :limit => 64
    t.string   "user_name",        :limit => 64
    t.string   "user_affiliation", :limit => 64
    t.string   "phone_number",     :limit => 64
    t.string   "user_address1"
    t.string   "user_address2"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_commons", :force => true do |t|
    t.string  "name_kanji",       :limit => 64
    t.string  "name_kana",        :limit => 64
    t.string  "phone_number",     :limit => 8
    t.string  "fax_number",       :limit => 8
    t.string  "cellphone_number", :limit => 8
    t.string  "cellphone_email"
    t.string  "zip_code",         :limit => 8
    t.string  "user_address1"
    t.string  "user_address2"
    t.integer "user_id",                        :null => false
    t.string  "skype_id"
  end

  add_index "user_commons", ["user_id"], :name => "index_user_commons_on_user_id", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "uid",                       :limit => 100
    t.string   "user_type",                 :limit => 1,   :default => "w"
  end

  add_index "users", ["uid"], :name => "index_users_on_uid", :unique => true

end
