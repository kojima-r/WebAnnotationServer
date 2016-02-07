open(ARGV[0]).each{|line|
	if line=~/\<%% rails ([^\s]*)\s*%%\>/
		key=$1
		if key=="base_path"
			puts "var base_path=\"/workspaces/project/\";"
		elsif key=="user_info"
			puts <<'USER_INFO'
<% if user_signed_in? %> 
  Logged in as
  <strong>
  <%= current_user.username %>
  </strong>. |
  <%= link_to "Projects", { :controller => :projects, :action => :index} %> |
  <%= link_to "Log out", destroy_user_session_path, method: :delete %>
<% else %>
	  <%= link_to "sign up", new_user_registration_path %> |
  <%= link_to "Log in", new_user_session_path %>
<% end %>
USER_INFO
		elsif key=="user_full_info"
			puts <<'USER_FULL_INFO'
<% if user_signed_in? %> 
  Logged in as
  <strong>
  <%= current_user.username %>
  </strong>(<%= current_user.email %>).
  <%= link_to "Projects", { :controller => :projects, :action => :index} %> |
  <%= link_to 'Edit', edit_user_registration_path %> |
  <%= link_to "Log out", destroy_user_session_path, method: :delete %>
<% else %>
	  <%= link_to "sign up", new_user_registration_path %> |
  <%= link_to "log in", new_user_session_path %>
<% end %>
USER_FULL_INFO
		elsif key=="project_id"
			puts 'var projectID=<%= @project.id %>;'
		end
	else
		print line
	end
	
}
