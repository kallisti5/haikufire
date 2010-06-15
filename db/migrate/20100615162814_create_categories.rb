class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
	t.string	:name
        t.text		:description
    end
	Category.create	:name => "Development",
			:description => "Applications or utilities relating to Haiku software development"
  end

  def self.down
    drop_table :categories
  end
end
