class Vote < ActiveRecord::Base
	belongs_to :election
	belongs_to :choice
end
