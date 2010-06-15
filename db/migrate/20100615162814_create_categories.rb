class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
	t.string	:name
        t.text		:description
    end

	Category.create	:name => "Development",
			:description => "Applications or utilities relating to Haiku software development"
	Category.create	:name => "Drivers",
			:description => "Haiku compatible drivers for your system"
	Category.create	:name => "Engineering",
			:description => "Engineering utilities"
	Category.create	:name => "Games",
			:description => "Games for the Haiku operating system."
	Category.create	:name => "Graphics",
			:description => "Applications to view or manipulate photos"
	Category.create	:name => "Internet",
			:description => "Applications or utilities relating to the world wide web"
	Category.create	:name => "Multimedia",
			:description => "Sound or video related applications."
	Category.create	:name => "Network",
			:description => "Local or remote network related applications and utilities."
	Category.create	:name => "Office",
			:description => "Document management or business related applications."
	Category.create	:name => "Utilities",
			:description => "General system utilities"
  end

  def self.down
    drop_table :categories
  end
end
