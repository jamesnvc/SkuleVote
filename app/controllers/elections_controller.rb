class ElectionsController < ApplicationController

  before_filter :authenticate, :except => [:index, :vote, :help]

  def index
    @elections = Election.all
    
  end

  def vote
    @election = Election.find(params[:id])
  
    @ballot = Ballot.new
    @vote = Vote.new
  end
  
  def admin
  	@active_elections = Election.all
  	@inactive_elections = Election.all
  end
  
  def help
  
  end

  def results
  	@election = Election.find(params[:id])
  end
  
  def votes
  	@election = Election.find(params[:id])
  end

  def new
    @election = Election.new
  end

  def edit
    @election = Election.find(params[:id])
  end

  def create
    @election = Election.new(params[:election])

    if @election.save
      flash[:notice] = 'Election was successfully created.'
      redirect_to(:action => 'admin')
    else
      render :action => "new"
    end
  end

  def update
    @election = Election.find(params[:id])

    if @election.update_attributes(params[:election])
      flash[:notice] = 'Election was successfully updated.'
      redirect_to(:action => 'admin')
    else
      render :action => "edit"
    end
  end

  def destroy
    @election = Election.find(params[:id])
    @election.destroy

    flash[:notice] = 'Election was successfully destroyed.'
    redirect_to(:action => 'admin')
  end
  
  protected
  
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "admin" && password == "pass"
    end
  end
  
end
