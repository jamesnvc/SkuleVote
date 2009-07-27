class Election < ActiveRecord::Base
	has_many :choices
	has_many :votes
	has_many :ballots
	
	accepts_nested_attributes_for :choices
	accepts_nested_attributes_for :votes
	accepts_nested_attributes_for :ballots
	
	def active
		#if current date falls within start/end date range
		return true
	end
end
