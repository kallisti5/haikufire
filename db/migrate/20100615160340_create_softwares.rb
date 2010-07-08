class CreateSoftwares < ActiveRecord::Migration
  def self.up
    create_table :softwares do |t|
      t.string		:title
      t.integer		:category_id
      t.timestamp	:created
      t.timestamp	:updated
      t.text		:description
      t.string		:author
      t.string		:version
      t.string		:license
      t.string		:type
      t.binary		:icon
    end

       Software.create  :title => "Test application",
                        :category_id => 1,
			:description => "Test software item",
			:author => "Jose fancy-pants",
			:license => "GPL",
			:version => "1.0",
			:created => Time.parse("5/20"),
			:updated => Time.parse("5/24"),
			:type => "Native"

       Software.create  :title => "Test application II",
                        :category_id => 1,
                        :description => "Test development software item",
                        :author => "Jose fancy-pants",
                        :license => "GPL",
			:version => "r102",
                        :created => Time.now,
                        :updated => Time.now,
                        :type => "Compatible"
  end

  def self.down
    drop_table :softwares
  end
end
