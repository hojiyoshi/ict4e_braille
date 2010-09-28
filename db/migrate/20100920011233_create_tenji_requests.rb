class CreateTenjiRequests < ActiveRecord::Migration
  def self.up
    create_table :tenji_requests do |t|
      t.column :req_id, :integer, :null => false
      t.column :req_date, :timestamp, :null => false
      t.column :accp_date, :timestamp
      t.column :req_title, :string, :limit => 100, :null => false
      t.column :req_sts, :string, :limit => 1
      t.column :download_date, :timestamp
      t.column :send_date, :timestamp
      t.column :stop_date, :timestamp
      t.column :data_name, :string, :limit => 100, :null => false
      t.column :data_flg, :string, :limit => 1 ,:default => '1'
      t.column :pdata_name, :string, :limit => 100
      t.column :pdata_flg, :string, :limit => 1
      t.column :from_lastname_kanji, :string, :limit => 64
      t.column :from_lastname_kana,  :string, :limit => 64
      t.column :from_firstname_kanji,:string, :limit => 64
      t.column :from_firstname_kana, :string, :limit => 64
      t.column :from_phone_number1,  :string, :limit => 8
      t.column :from_phone_number2,  :string, :limit => 8
      t.column :from_phone_number3,  :string, :limit => 8
      t.column :from_fax_number1,    :string, :limit => 8
      t.column :from_fax_number2,    :string, :limit => 8
      t.column :from_fax_number3,    :string, :limit => 8
      t.column :from_cellphone_number1, :string, :limit => 8
      t.column :from_cellphone_number2, :string, :limit => 8
      t.column :from_cellphone_number3, :string, :limit => 8
      t.column :from_email, :string, :limit => 255
      t.column :from_zip_code, :string, :limit => 8
      t.column :from_user_address1, :string, :limit => 16
      t.column :from_user_address2, :string, :limit => 255
      t.column :from_user_address3, :string, :limit => 255
      t.column :from_user_address4, :string, :limit => 255
      t.column :from_user_address5, :string, :limit => 255
      t.column :to_lastname_kanji, :string, :limit => 64
      t.column :to_lastname_kana,  :string, :limit => 64
      t.column :to_firstname_kanji,:string, :limit => 64
      t.column :to_firstname_kana, :string, :limit => 64
      t.column :to_phone_number1,  :string, :limit => 8
      t.column :to_phone_number2,  :string, :limit => 8
      t.column :to_phone_number3,  :string, :limit => 8
      t.column :to_fax_number1,    :string, :limit => 8
      t.column :to_fax_number2,    :string, :limit => 8
      t.column :to_fax_number3,    :string, :limit => 8
      t.column :to_cellphone_number1, :string, :limit => 8
      t.column :to_cellphone_number2, :string, :limit => 8
      t.column :to_cellphone_number3, :string, :limit => 8
      t.column :to_email, :string, :limit => 255
      t.column :to_zip_code, :string, :limit => 8
      t.column :to_user_address1, :string, :limit => 16
      t.column :to_user_address2, :string, :limit => 255
      t.column :to_user_address3, :string, :limit => 255
      t.column :to_user_address4, :string, :limit => 255
      t.column :to_user_address5, :string, :limit => 255
    end
  end

  def self.down
    drop_table :tenji_requests
  end
end
