class CreateDownloads < ActiveRecord::Migration
  def self.up
    create_table :downloads do |t|
      t.integer :software_id
      t.integer :arch_id
      t.string :dl_file_name
      t.string :dl_content_type
      t.integer :dl_file_size

      t.timestamps
    end
  end

  def self.down
    drop_table :downloads
  end
end
