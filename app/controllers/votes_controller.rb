class VotesController < ApplicationController
  # POST /votes
  # POST /votes.xml
  def create
    @election = Election.find(params[:election][:id])
    
    @votes = @election.votes.build params[:vote].values
    @ballot = @election.ballots.build :sp_id => 1234
    #@ballot.sp_id = 1234
    
    
    if @election.save
      flash[:notice] = 'Vote was successfully cast.'
      redirect_to("/")
    else
      render :action => "new"
    end
    
  end

end
