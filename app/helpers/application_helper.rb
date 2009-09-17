# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def calculate_winner_preferential(election)
    candidates = { }
    candidates.default = 0
    
    election.ballots.each do |ballot|
      ballot.votes.each do |vote|
        if vote.result == 1
          candidates[vote.choice_id] += 1
        end
      end
    end
    # Counting the number of counted votes means we will automatically discount
    # ballots that have had all their candidates eliminated
    total = candidates.values.inject { |a,b| a + b }
    
    # Check if the majority of votes were spoiled, in which case the election is void
    spoiled = candidates.keys.reject { |c| c != 0 }.size
    if spoiled >= total/2
      return :spoiled # How do we want to indicate this?
    end
    
    leader = candidates.max { |a,b| a[1] <=> b[1] }
    if leader[1] >= total/2
      return leader[0]
    else
      loser = candidates.min { |a,b| a[1] <=> b[1] }
      adjusted_election = remove_candidate(loser[0])
      calculate_winner_preferential(adjusted_election)
    end
  end

  def remove_candidate(candidate_id, election)
    election.ballots.each do |ballot|
      # TODO: Also need to shift values up now
      ballot.votes.each do |vote|
        if vote.result == 1 && vote.choice_id == candidate_id
          vote.result = -1
          # Shift the other votes up
          ballot.votes.each do |v|
            if v.result != -1
              v.result -= 1
            end # if
          end # each v
          next
        end # each if
      end # each v
    end #each b
    return election
  end #def
end
