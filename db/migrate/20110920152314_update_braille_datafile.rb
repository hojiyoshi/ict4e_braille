class UpdateBrailleDatafile < ActiveRecord::Migration
  def self.up
    add_column :tenji_requests, :braille_datafile2,       :string,  :limit => 255
    add_column :tenji_requests, :braille_datafile3,        :string,  :limit => 255
    rename_column :tenji_requests, :braille_datafile, :braille_datafile1
  end

  def self.down
    remove_column :tenji_requests, :braille_datafile2
    remove_column :tenji_requests, :braille_datafile3
    rename_column :tenji_requests, :braille_datafile1, :braille_datafile
  end
end
