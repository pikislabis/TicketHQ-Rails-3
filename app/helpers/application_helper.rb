module ApplicationHelper
  def opciones_borrado
  	{ :method => :delete, :confirm => 'Esta seguro?'}
 	end

	def link_to_file(name, file, *args)
		if file != ?/
			file = "#{file}"
		end
		link_to name, file, *args
	end

	def observe_project?(user, project)
		observe = false
		groups = user.groups & project.groups
		groups.each do |x|
			x.observe ? (observe = true; break) : nil
		end
		observe
	end

	def label_size(labels, element)
		(((labels[element] / labels.map{|k,v| labels[k]}.sum.to_f) * 100) + 5).to_i
	end

end
