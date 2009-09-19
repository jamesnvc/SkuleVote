# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def calculate_winner_preferential election
    candidates = { }
    candidates.default = 0
    
    election.ballots.each do |ballot|
      ballot.votes.each do |vote|
        candidates[vote.choice_id] += 1 if vote.result == 1
      end
    end
    
    total = candidates.values.sum
    
    # Check if the majority of votes were spoiled, in which case the election is void
    spoiled = candidates.keys.select { |c| c == 0 }.size
    if spoiled > total/2.0
      return [:spoiled , spoiled] # How do we want to indicate this?
    end
    
    leader_id, leader_votes = candidates.max { |a,b| a[1] <=> b[1] }
    loser_id, loser_votes = candidates.min { |a,b| a[1] <=> b[1] }
    
    if loser_votes == leader_votes
      # There must be either a tie or a degenerate election
      if candidates.size == 1 # Only one candidate, must be the winner
        return [leader_id, spoiled]
      else
        # TODO: add tie-breaking code here
        return [candidates.select { |c_id,votes|
          votes == leader_votes and c_id != 0 }.map { |c_id,votes| c_id }, spoiled]
      end
    end
    
    if leader_votes > total/2.0
      # max only returns one candidate, so check if two have the same amount of votes
      if candidates.select { |c_id,votes| votes == leader_votes }.size > 1
        # Tie; return the tied candidates
        # TODO: Add tie-breaking code here
        return [candidates.select { |c_id,votes| votes == leader_votes }.map { |c_id,votes| c_id }, spoiled]
      else
        return [leader_id, spoiled]
      end
    else
      # Eliminate lowest-scoring candidate and re-run the vote counting
      adjusted_election = remove_candidate(loser_id, election)
      return calculate_winner_preferential(adjusted_election)
    end
    
  end

  def remove_candidate candidate_id, election
    election.ballots.each do |ballot|
      ballot.votes.each do |vote|
        if vote.result == 1 && vote.choice_id == candidate_id
          vote.result = -1
          # Shift the other votes up
          ballot.votes.each { |v| v.result -= 1 if v.result != -1 and !v.result.nil? }
          next
        end # each if
      end # each v
    end #each b
    return election
  end #def
  
end
