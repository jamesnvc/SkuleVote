# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  filter_parameter_logging :sid
  helper_method :current_voter_session, :current_voter

  private
  
  
    
    def current_voter_session
      return @current_voter_session if defined?(@current_voter_session)
      @current_voter_session = VoterSession.find
    end

    def current_voter
      return @current_voter if defined?(@current_voter)
      @current_voter = current_voter_session && current_voter_session.voter
    end
    
    def require_voter
      unless current_voter
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to :controller => :elections, :action => :public
        return false
      end
    end
    
    def require_no_voter
      if current_voter
        store_location
        flash[:notice] = "You must be logged out to access this page."
        redirect_to :controller => :elections, :action => :index
        return false
      end
    end
    
    def store_location
      session[:return_to] = request.request_uri
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end

end
