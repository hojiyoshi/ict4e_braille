class UpdatePrintName < ActiveRecord::Migration
  def self.up
    add_column :tenji_requests, :print_name2,       :string,  :limit => 255
    add_column :tenji_requests, :print_name3,        :string,  :limit => 255
    rename_column :tenji_requests, :print_name, :print_name1
  end

  def self.down
    remove_column :tenji_requests, :print_name2
    remove_column :tenji_requests, :print_name3
    rename_column :tenji_requests, :print_name1, :print_name
  end
end
