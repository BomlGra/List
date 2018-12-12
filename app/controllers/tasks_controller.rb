class TasksController < ApplicationController
  before_action :authenticate_user!
  def index
    @task = Task.new
    @task.user = current_user
    @tasks = current_user.tasks.order(created_at: :desc)
  end

  def create
    @task = Task.new(tasks_params)
    @task.user = current_user
    if @task.save
      redirect_to root_path
    else
      redirect_to root_path
    end

  end

  def get_text
    id = params[:id].to_i
    render json: {text: current_user.tasks.find(id).text}
  end
  def edit
    @task = current_user.tasks.find(params[:id])
  end

  def update
    @task = current_user.tasks.find(params[:id])

    if @task.update(tasks_params)
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def done
    @task = current_user.tasks.find(params[:id])

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