class VotesController < ApplicationController

  before_filter :require_voter
  
  # POST /votes
  # POST /votes.xml
  def create
    @election = Election.find(params[:election][:id])
    
    @ballot = Ballot.new
    @election.ballots << @ballot
    
    if params[:commit] == "Spoil Ballot"
      @ballot.votes << Vote.new(:choice_id => 0, :result => 1, :election_id => @election.id)
    elsif   
      if @election.method == "single_choice"
        @ballot.votes << Vote.new(:choice_id => params[:vote_single][:choice_id], :result => 1, :election_id => @election.id)
      else #preferential and multiple choice elections
    	  @votes = @election.votes.build params[:vote].values
    	  @votes.each do |v|
    	    v.ballot_id = @ballot.id
    	  end
        #@votes = @ballot.votes.build params[:vote].values
      end
    end
    
    @election.voters << current_voter
    
    if @election.save
      if params[:commit] == "Spoil Ballot"
        flash[:notice] = 'Ballot was succesfully spoiled.'
      else
        flash[:notice] = 'Vote was successfully cast.'
      end
      redirect_to("/")
    else
      render :action => "new"
    end
    
  end

end
