class Election < ActiveRecord::Base
	has_many :choices
	
	def active
		#if current date falls within start/end date range
		return true
	end
end
