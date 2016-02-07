class TasksController < ApplicationController
  before_action :authenticate_user!

  def index
	p "******************:"
	p current_user
	p "******************:"
  end

  def show
	p "******************:"
	p current_user
	p "******************:"
	WorkerForSidekiq.perform_async("task:"+current_user.username)
	render json: current_user
  end


end
