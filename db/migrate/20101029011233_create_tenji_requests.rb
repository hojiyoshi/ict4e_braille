class CreateTenjiRequests < ActiveRecord::Migration
  def self.up
    create_table :tenji_requests do |t|
      t.string   :from_zip_code,         :limit => 64,  :null => false
      t.string   :from_user_name,        :limit => 64,  :null => false
      t.string   :from_user_affiliation, :limit => 64
      t.string   :from_phone_number,     :limit => 64
      t.string   :from_user_address1,    :limit => 255, :null => false
      t.string   :from_user_address2,    :limit => 255
      t.string   :to_zip_code,           :limit => 64,  :null => false
      t.string   :to_user_name,          :limit => 64,  :null => false
      t.string   :to_user_affiliation,   :limit => 64
      t.string   :to_phone_number,       :limit => 64
      t.string   :to_user_address1,      :limit => 255, :null => false
      t.string   :to_user_address2,      :limit => 255
      t.integer  :user_id,         :null => false
      t.string   :print_name,            :limit => 255, :null => false
      t.string   :print_title1,          :limit => 255
      t.string   :print_title2,          :limit => 255
      t.string   :print_title3,          :limit => 255
      t.text     :print_contents1,       :null => false
      t.text     :print_contents2
      t.text     :print_contents3
      t.string   :attached_file,         :limit => 255
      t.string   :braille_xmlfile,       :limit => 255
      t.text     :message
      t.datetime :created_at
      t.datetime :updated_at
      t.string   :data_type,       :limit => 32
    end
  end

  def self.down
    drop_table :tenji_requests
  end
end
