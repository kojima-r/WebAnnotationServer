class WorkspaceGeneratorWorker
  
  include Sidekiq::Worker
  def create_workspace(user)
	# copy
	wd=Dir::pwd
	p "... copying workspace:(wd: "+wd+" )"
	src="WebAnnotationToolForBirds"
	dest="projects/"+user
	FileUtils.cp_r(src,dest)
    p "sidekiq: #{src} => #{dest} (wd: #{Dir.pwd})"
    # make link
	ln_from="./projects/"+user+"/audio"
	ln_to="../../public/uploads/project/"+user+"/"
	FileUtils.ln_s(ln_to,ln_from)
  end
  

  def perform(username)
    create_workspace(username)
  end
end
