class WelcomeController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]

  def index
  	respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

end
