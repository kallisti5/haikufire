class Software < ActiveRecord::Base
	belongs_to :category

	validates_uniqueness_of :title

end
