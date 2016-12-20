class AjaxController < ApplicationController
	before_filter :authenticate_user!, :except => [:campus]

  def campus
  	limit_amount = 8
  	if params[:term]
      campus_list = Campus.where("name like ?", "%#{params[:term]}%").limit(limit_amount)
    else
      campus_list = Campus.limit(limit_amount)
    end

  	#render json: campus_list.map { |i| Hash[label: "#{i.name}, #{i.city}, #{i.state}", value: i.name ] }
  	render json: campus_list.map { |i| "#{i.name}, #{i.city}, #{i.state}" }
  end
end
