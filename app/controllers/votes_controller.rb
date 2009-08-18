class VotesController < ApplicationController
  # POST /votes
  # POST /votes.xml
  def create
    @election = Election.find(params[:election][:id])
    @election.ballots << Ballot.new(:sp_id => 1234)
    
    if params[:commit] == "Spoil Ballot"
      
      @election.votes << Vote.new(:choice_id => 0, :result => 1)
        
    elsif    
	    if params[:vote_single] #Radio Button single choice elections
	    	@election.votes << Vote.new(:choice_id => params[:vote_single][:choice_id], :result => 1)
	    else #preferential and multiple choice elections
	    	@votes = @election.votes.build params[:vote].values
	    end
    end
    
    if @election.save
      flash[:notice] = 'Vote was successfully cast.'
      redirect_to("/")
    else
      render :action => "new"
    end
    
  end
  
  def spoil
    @election = Election.find(params[:election][:id])
    if @election.save
      flash[:notice] = 'Ballot was successfully spoiled.'
      redirect_to("/")
    else
      render :action => "new"
    end
  end

end
