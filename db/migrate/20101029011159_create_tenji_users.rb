class CreateTenjiUsers < ActiveRecord::Migration
  def self.up
    create_table "tenji_users" , :force => true do |t|
      t.integer  :user_id,          :null => false
      t.string   :tenji_type,       :limit => 1,  :null =>false, :default => 'f'
      t.string   :zip_code,         :limit => 64
      t.string   :user_name,        :limit => 64
      t.string   :user_affiliation, :limit => 64
      t.string   :phone_number,     :limit => 64
      t.string   :user_address1,    :limit => 255
      t.string   :user_address2,    :limit => 255
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def self.down
    drop_table "tenji_users"
  end
end
