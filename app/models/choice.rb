class Choice < ActiveRecord::Base
	belongs_to :election
	has_many :votes
	
	validates_presence_of :name
	
	def text
		if self.name == 't'
			return "Yes"
		elsif self.name == "f"
			return "No"
		else
			return self.name
		end
	end
	
	def value
		if self.name == 't'
			return 1
		elsif self.name == 'f'
			return 0
		else
			return self.name
		end
	end
end
