class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def init_project
    @project.username=current_user.username
    @project.tf="microcone_geotf.zip"
	@project.loc_src_num=1
	@project.loc_thresh=27
	@project.loc_lowest_freq=2400
	@project.sep_pause=1200
	@project.sep_min_interval=10
	@project.sep_lowest_freq=1000
	@project.status=0
  end
  # GET /projects
  # GET /projects.json
  def index
	#p User.where("username not ?", nil)
	#p "==="
	#p current_user
    #@projects = Project.all
    @projects = current_user.projects
    @auto_reload_flag=false
	@projects.each do |project|
		if project.status==0
    		@auto_reload_flag=true
		end
	end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new()
	init_project()
  end

  # GET /projects/1/edit
  def edit
  end
  
  def list_labels
    @projects=current_user.projects
    @project = @projects.find(params[:id])
    @project_labels= @project.labels
    @labels=[]
    @project_labels.find_each{|label|
		@labels<<{"id":label.id,"name":label.name}#,"color":label.color}
	}
	render json: @labels
  end

  def edit_labels
    @projects=current_user.projects
    @project = @projects.find(params[:id])
    @project_labels= @project.labels
    @labels=[]
	Label.all.find_each{|label|
		@labels<<{"id":label.id,"name":label.name}#,"color":label.color}
	}
  end
  # POST /projects/:id/update_labels
  def update_labels
	p params
    @projects=current_user.projects
    @project = @projects.find(params[:id])
    p params
    if params.key?(:add_selector)
    	label_id=params[:add_selector]
		loc_label=LocalLabel.find_by(label_id: label_id.to_i,project_id: @project.id)
		if loc_label==nil
			@project.labels<<Label.find(label_id.to_i)
		end
	elsif params.key?(:delete_selector)
    	label_id=params[:delete_selector]
		loc_label=LocalLabel.find_by(label_id: label_id.to_i,project_id: @project.id)
		loc_label.delete
	end
    @project_labels= @project.labels
    @labels=[]
	Label.all.find_each{|label|
		@labels<<{"id":label.id,"name":label.name}#,"color":label.color}
	}

	#render action: :edit_labels
	render json: {}
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    @project.username=current_user.username
	current_user.projects<<@project

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
	p "... creating project:",current_user
	ProjectGeneratorWorker.perform_async(@project.id)
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
	@project.status=0
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
	p "... creating project:",current_user
	ProjectGeneratorWorker.perform_async(@project.id)
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      #params.require(:project).permit(:name, :price)
      params.require(:project).permit(:name, :wav, :wav_cache, :remove_wav,:status,
:username,:tf,:loc_src_num,:loc_thresh,:loc_lowest_freq,:sep_pause,:sep_min_interval,:sep_lowest_freq)

    end
end
