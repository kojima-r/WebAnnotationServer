class WorkspacesController < ApplicationController
  before_action :authenticate_user!
  def new
  end

  def show
	project_id=params["project_id"]
	@projects=current_user.projects
	@project=@projects.find(project_id)
	render :layout => false
  end 
  def project
    p params
	annotation_tool_path="./projects/"+current_user.username+"/public/"
	proj=params["proj_name"]
	res=params["resource"]
	ext=params["format"]
	path=annotation_tool_path+"/"+proj+"/"+res+"."+ext
	filename=res+"."+ext
	if ext=="csv" or ext=="txt" or ext=="json" 
	send_data(
		File.read(path),
		type: 'plain/text',
		filename: filename
	)
	else
	send_data(
		File.read(path),
		type: 'application/octet-stream',
		filename: filename
	)
	end
  end
end
