class Vote < ActiveRecord::Base
	belongs_to :election
	belongs_to :choice
	belongs_to :ballot
end
