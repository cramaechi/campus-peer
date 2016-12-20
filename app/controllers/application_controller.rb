class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!
  
  layout :layout_by_resource

  private

  def after_sign_in_path_for(resource)
    return homepage_index_path
  end

  # Will return hex string that is 4 chars long.
  def generate_peertag
  	while true
  	  peertag = SecureRandom.hex(2).upcase
  	  if BookTransaction.where("peertag = ?", peertag).count == 0
  	  	return peertag
  	  end
  	end
  end



  protected
  
  def layout_by_resource
    if devise_controller?
      "users"
    elsif self.class.to_s == "WelcomeController"
      "simple"
    else
      "student"
    end
  end
end
