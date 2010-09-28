class CreateTenjiUsers < ActiveRecord::Migration
  def self.up
    create_table "tenji_users" , :force => true do |t|
      t.column :user_id,        :integer, :null => false
      t.column :tenji_type,     :string, :limit => 1, :null =>false, :default => 'f'
      t.column :lastname_kanji, :string, :limit => 64
      t.column :lastname_kana,  :string, :limit => 64
      t.column :firstname_kanji,:string, :limit => 64
      t.column :firstname_kana, :string, :limit => 64
      t.column :phone_number1,  :string, :limit => 8
      t.column :phone_number2,  :string, :limit => 8
      t.column :phone_number3,  :string, :limit => 8
      t.column :fax_number1,    :string, :limit => 8
      t.column :fax_number2,    :string, :limit => 8
      t.column :fax_number3,    :string, :limit => 8
      t.column :cellphone_number1, :string, :limit => 8
      t.column :cellphone_number2, :string, :limit => 8
      t.column :cellphone_number3, :string, :limit => 8
      t.column :cellphone_email, :string, :limit => 255
      t.column :zip_code,        :string, :limit => 8
      t.column :user_address1, :string, :limit => 16
      t.column :user_address2, :string, :limit => 255
      t.column :user_address3, :string, :limit => 255
      t.column :user_address4, :string, :limit => 255
      t.column :user_address5, :string, :limit => 255
    end
  end

  def self.down
    drop_table "tenji_users"
  end
end
