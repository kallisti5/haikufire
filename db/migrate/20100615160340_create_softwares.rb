class CreateSoftwares < ActiveRecord::Migration
  def self.up
    create_table :softwares do |t|
      t.string	:title
      t.integer	:category
      t.text	:description
      t.string	:author
      t.string	:license
      t.string	:type
      t.binary	:icon
    end
  end

  def self.down
    drop_table :softwares
  end
end
