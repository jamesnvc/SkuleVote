class BallotsController < ApplicationController

  # POST /ballots
  # POST /ballots.xml
  def create
    @ballot = Ballot.new(params[:ballot])

    respond_to do |format|
      if @ballot.save
        flash[:notice] = 'Ballot was successfully created.'
        format.html { redirect_to(@ballot) }
        format.xml  { render :xml => @ballot, :status => :created, :location => @ballot }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ballot.errors, :status => :unprocessable_entity }
      end
    end
  end

end
