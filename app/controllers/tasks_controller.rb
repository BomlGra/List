class TasksController < ApplicationController
  before_action :authenticate_user!, except: []
  def index
    @task = Task.new
    @tasks = Task.all.order(created_at: :desc)
  end

  def create
    @task = Task.new(tasks_params)
    if @task.save
      redirect_to root_path
    else
      redirect_to root_path
    end

  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])

    if @task.update(tasks_params)
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def done
    @task = Task.find(params[:id])

    if @task
      @task.status = "true"

      redirect_to root_path if @task.save
    else
      redirect_to root_path
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    redirect_to root_path
  end

  private
  def tasks_params
    params.require(:task).permit(:title, :text)
  end
end