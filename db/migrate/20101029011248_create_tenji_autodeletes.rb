class CreateTenjiAutodeletes < ActiveRecord::Migration
  def self.up
    create_table :tenji_autodeletes do |t|
      t.column :days, :string
    end
  end

  def self.down
    drop_table :tenji_autodeletes
  end
end
