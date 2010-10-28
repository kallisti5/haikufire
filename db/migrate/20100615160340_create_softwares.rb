class CreateSoftwares < ActiveRecord::Migration
  def self.up
    create_table :softwares do |t|
      t.string		:title
      t.integer		:category_id
      t.integer		:user_id			# creator
      t.timestamp	:created
      t.timestamp	:updated
      t.text		:description
      t.string		:author
      t.string		:website
      t.string		:version
      t.string		:license
      t.string		:compiled
      t.string		:icon_file_name			# paperclip icon assets
      t.string		:icon_content_type
      t.integer		:icon_file_size
      t.string		:screenshot_file_name		# paperclip screenshot assets
      t.string		:screenshot_content_type
      t.integer		:screenshot_file_size
    end
  end

  def self.down
    drop_table :softwares
  end
end
