module Results::Preferential
  
  # Determine the winner of a preferential-type election
  def self.calculate_winner_preferential election
    candidates = { }
    candidates.default = 0
    
    election.ballots.each do |ballot|
      ballot.votes.each do |vote|
        candidates[vote.choice_id] += 1 if vote.result == 1
      end
    end
    
    total = candidates.values.sum
    
    # Check if the majority of votes were spoiled, in which case the election is void
    spoiled = candidates[0]
    if spoiled > total/2.0
      return [:spoiled , spoiled] # How do we want to indicate this?
    end

    # For most of the next calculations, we only want actual candidates, i.e. not spoiled ballots
    real_candidates = candidates.reject {|k,v| k == 0 }
    
    # Find the candidates with the most and least votes
    leader_id, leader_votes = real_candidates.max { |a,b| a[1] <=> b[1] }
    loser_id, loser_votes = real_candidates.min { |a,b| a[1] <=> b[1] }

    # Create a closure that we'll use to resolve ties
    resolve_tie = lambda do # have to use a lambda to capture variables in the outer scope
      # Currently just return all the tied candidates
      tied = real_candidates.select { |c_id,votes| votes == leader_votes }
      return [tied.map { |c_id,votes| c_id }, spoiled]
    end
    
    if loser_votes == leader_votes
      # There must be either a tie or a degenerate election
      if real_candidates.size == 1 # Only one candidate, must be the winner
        return [leader_id, spoiled]
      else
        # TODO: add tie-breaking code here
        return resolve_tie.call
      end
    end
    
    if leader_votes > total/2.0
      # max only returns one candidate, so check if two have the same amount of votes
      if real_candidates.values.select { |votes| votes == leader_votes }.size > 1
        # Tie; return the tied candidates
        # TODO: Add tie-breaking code here
        return resolve_tie.call
      else
        return [leader_id, spoiled]
      end
    else
      # Eliminate lowest-scoring candidate and re-run the vote counting
      return calculate_winner_preferential( self.remove_candidate(loser_id, election) )
    end
    
  end

  # Helper function for calculate_winner_preferential
  # Returns the election with the candidate with the given id removed
  def self.remove_candidate candidate_id, election
    election.ballots.each do |ballot|
      ballot.votes.each do |vote|
        if vote.result == 1 && vote.choice_id == candidate_id
          vote.result = -1
          # Shift the other votes up
          ballot.votes.each { |v| v.result -= 1 if !v.result.nil? and v.result >= 0 }
          next
        end # each if
      end # each v
    end #each b
    return election
  end #def
  
end
