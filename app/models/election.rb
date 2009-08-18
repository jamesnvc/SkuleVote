class Election < ActiveRecord::Base
	has_many :choices, :dependent => :destroy
	has_many :votes, :dependent => :destroy
	has_many :ballots, :dependent => :destroy
	
	validates_presence_of :name
	
	accepts_nested_attributes_for :choices, 
		:allow_destroy => true,
		#:reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
		:reject_if => proc { |a| a['name'].blank? }
	#use with rails edge
	#accepts_nested_attributes_for :choices, :reject_if => :all_blank, :allow_destroy => true
	accepts_nested_attributes_for :votes
	accepts_nested_attributes_for :ballots
	
	def active?
		#if current date falls within start/end date range
		return Time.now.between?(self.start, self.end)
	end
	
	def method
	  if self.preferential
	    return "preferential"
	  elsif self.max_choices == 1
	    return "single_choice"
	  else
	    return "multiple_choice"
	  end  
	end
end
