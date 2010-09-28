class CreateIct4eMasterData < ActiveRecord::Migration
  def self.up
    create_table :ict4e_master_data do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :ict4e_master_data
  end
end
