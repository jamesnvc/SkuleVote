class VoterSessionsController < ApplicationController
  before_filter :require_voter, :only => :destroy
  before_filter :validate_params, :only => :new
  
  #LOGIN
  def new	
	#if voter already exists -> login
    if @voter = Voter.find(:first, :conditions => {:sid => params[:sid]})
      @voter_session = VoterSession.new(@voter)
      if @voter_session.save
        flash[:notice] = "Login Succesful!"
        redirect_to :controller => :elections, :action => :index
      else
        flash[:notice] = "Login Fail."
        render_to :controller => :election, :action => :public
      end
    else #create new voter
      @voter = Voter.new()
      #filter params
		@voter.student = params[:isstudent] == "True" #Bool
		@voter.registered = params[:isregistered] == "True" #Bool
		@voter.undergrad = params[:isundergrad] == "True" #Bool
		@voter.org = params[:primaryorg] #String, ex. APSC
		@voter.year = params[:yofstudy] #Integer
		@voter.campus = params[:campus] #String, ex. SGT
		@voter.discipline = params[:postcd][2...5]
		@voter.attendance = params[:attendance] #FT / PT
		@voter.pey = (params[:assocorg] == "AEPEY") #Bool
		@voter.sid = params[:sid] #String
    
      if @voter.save
        flash[:notice] = "Login successful."
        redirect_to :controller => :elections, :action => :index
      else
        @voter_session = VoterSession.new
        flash[:notice] = "Cannot Create Voter"
        render_to :controller => :election, :action => :public
      end  
    end
  end
  
  #LOGOUT
  def destroy
    #current_voter.destroy
    current_voter_session.destroy
    flash[:notice] = "Logout successful. Thank you for using SkuleVote. Have a nice day!"
    redirect_to :controller => :elections , :action => :public
  end
  
  private
    def validate_params 	
      password = "password" #move to some config file
  	
      #store hash
      hash_given = params[:hash]
      
      #remove auto-include values and hash from params variable
      params.delete(:action)
      params.delete(:controller)
      params.delete(:hash)
    
      #valid = hashof((concatofparameters-hash)+password) == hashinparams
      hash_check = Digest::MD5.hexdigest(params.values.to_s+password)
      valid = (hash_check == hash_given)
	  
      if !valid
        flash[:notice] = "The link you followed was incorrect. Please try again."+hash_check
      	redirect_to :controller => :elections, :action => :public
      end 
    end
  
end
