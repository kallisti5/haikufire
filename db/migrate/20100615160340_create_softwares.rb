class CreateSoftwares < ActiveRecord::Migration
  def self.up
    create_table :softwares do |t|
      t.string		:title
      t.integer		:category_id
      t.integer		:creator
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
      t.string		:download_file_name		# paperclip download asset
      t.string		:download_content_type
      t.integer		:download_file_size
    end

       Software.create  :title => "Test application",
                        :category_id => 1,
			:creator => 1,
			:website => "http://fancypants.com",
			:description => "Test software item\n* Produces test data\n* Full of win\n* Migrates cleanly",
			:author => "Jose fancy-pants",
			:license => "GPL",
			:version => "1.0",
			:created => Time.parse("5/20"),
			:updated => Time.parse("5/24"),
			:compiled => "Native"

       Software.create  :title => "Test application II",
                        :category_id => 1,
			:creator => 1,
			:website => "http://fancypants.com",
                        :description => "Test development software item",
                        :author => "Jose fancy-pants",
                        :license => "GPL",
			:version => "r102",
                        :created => Time.now,
                        :updated => Time.now,
                        :compiled => "Compatible"
  end

  def self.down
    drop_table :softwares
  end
end
