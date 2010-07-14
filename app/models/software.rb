class Software < ActiveRecord::Base
	belongs_to :category

	validates_uniqueness_of :title

	validates_presence_of :title
	validates_presence_of :category_id
	validates_presence_of :author
end
