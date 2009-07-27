class Choice < ActiveRecord::Base
	belongs_to :election
	
	
	def text
		if self.name == 't'
			return "Yes"
		elsif self.name == "f"
			return "No"
		else
			return self.name
		end
	end
end
