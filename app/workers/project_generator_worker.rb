class ProjectGeneratorWorker
  include Sidekiq::Worker
  def perform(project_id)
	  @project = Project.find(project_id)
	  p @project
	  config={}
	  config["name"]=@project.name
      p @project.wav
      p @project.wav.file
	  config["audio_name"]=@project.wav.file.filename
	  config["tf"]=@project.tf
	  config["loc_src_num"]=@project.loc_src_num
	  config["loc_thresh"]=@project.loc_thresh
	  config["loc_lowest_freq"]=@project.loc_lowest_freq
	  config["sep_lowest_freq"]=@project.sep_lowest_freq
	  config["sep_pause"]=@project.sep_pause
	  config["sep_min_interval"]=@project.sep_min_interval

	  wd=Dir::pwd
	  p "... creating config:(wd: "+wd+" )"
	  path="./projects/"+@project.username+"/"
	  text= ERB.new(File.read(path+"config.sh.erb")).result(binding)
	  fp=open(path+"config.sh","w")
      fp.puts text
      fp.close
      
	  Dir::chdir(path)
	  p "... creating project:(wd: "+wd+" => "+path+")"
	  IO.popen("bash ./create_project.sh") do |pipe|
        pipe.each do | line |
		  print line
        end
	  end
	  p "... localization/separation"
	  IO.popen("bash ./init_hark.sh") do |pipe|
        pipe.each do | line |
		  print line
        end
	  end

	  @project.status=1
	  if @project.save
		  p "success!!"
      else
		  p "fail !"
      end
	  Dir::chdir(wd)
  
  end
end
