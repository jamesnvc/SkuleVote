class ElectionsController < ApplicationController

  before_filter :authenticate, :except => [:index, :vote, :help]

  def index
    @elections = Election.all
    # should include .active conditional here, or via sql
    
  end

  def vote
    @election = Election.find(params[:id])
    
    if @election.random
    	@choices = @election.choices.sort_by {rand}
    else
      @choices = @election.choices
    end
    
    @ballot = Ballot.new
    @vote = Vote.new
  end
  
  def admin
  	@elections = Election.all
  end
  
  def help
  
  end

  def results
  	@election = Election.find(params[:id])  	
  end
  
  def ballots
  	@election = Election.find(params[:id])
  	
  	@spoiled = @election.votes.find(:all, :conditions => {:choice_id => 0 })
  end

  def add_choice
  	@choice = Choice.new
  end

  def new
    @election = Election.new
    @choice = Choice.new
    @election.choices << @choice
  end

  def edit
    @election = Election.find(params[:id])
  end

  def create
    @method = params[:election][:method]
    params[:election].delete(:method)
    
    @election = Election.new(params[:election])
    
    #should be a before_save filter
    case @method
    	when "preferential"
    	  @election.preferential = true
      when "single_choice"
        params[:election][:max_choices] = 1
        @election.preferential = false
      when "multiple_choice"
        @election.preferential = false	
      else
        #raise error  
    end if false

    if @election.save
      flash[:notice] = 'Election was successfully created.'
      redirect_to(:action => 'admin')
    else
      render :action => "new"
    end
  end

  def update
    @method = params[:election][:method]
    params[:election].delete(:method)
  
    @election = Election.find(params[:id])
    
    #should be a before_save filter
    case @method
    	when "preferential"
    	  @election.preferential = true
      when "single_choice"
        params[:election][:max_choices] = 1
        @election.preferential = false
      when "multiple_choice"
        @election.preferential = false	
      else
        #raise error  
    end

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
