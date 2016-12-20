module ApplicationHelper
	def sortable(column, title = nil, params_hash = {})
		title ||= column.titleize
		direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
		css_class = column == sort_column ? "current #{sort_direction}" : nil
		params_hash[:sort], params_hash[:direction] = column, direction
		link_to title, params_hash, :class => css_class
	end
end
