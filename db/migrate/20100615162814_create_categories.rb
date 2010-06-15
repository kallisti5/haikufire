class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
	t.string	:name
        t.text		:description
    end
	self.create	:name => "Development",
			:description => "Applications or utilities relating to Haiku software development", :value => 1
  end

  def self.down
    drop_table :categories
  end
end
