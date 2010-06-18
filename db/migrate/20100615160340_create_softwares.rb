class CreateSoftwares < ActiveRecord::Migration
  def self.up
    create_table :softwares do |t|
      t.string	:title
      t.integer	:category_id
      t.text	:description
      t.string	:author
      t.string	:license
      t.string	:type
      t.binary	:icon
    end

       Software.create  :title => "Test application",
                        :category_id => 1,
			:description => "Test software item",
			:author => "Jose fancy-pants",
			:license => "GPL",
			:type => "Native"

  end

  def self.down
    drop_table :softwares
  end
end
