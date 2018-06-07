class TasksController < ApplicationController
    before_action :require_user_logged_in
    before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = current_user.tasks.page(params[:page])
  end
  
  def show
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
    
    if@task.save
      flash[:success] = "タスクが正常に作成されました"
      redirect_to @task
    else
      flash.now[:danger] = "タスクが正常に作成されませんでした"
      render:new
    end
  end
  
  def edit
 
  end
  
  def update
    if@task.update(task_params)
      flash[:success] = "タスクが正常に更新されました"
      redirect_to @task
    else
      flash.now[:danger] = "タスクは更新されませんでした"
      render:edit
    end
    
  end
  
  def destroy
    @task.destroy
    
    flash[:success] = "タスクが正常に削除されました"
    redirect_to tasks_url
      
  end
  
  private

  def set_task
#   @task = Task.find(params[:id])

    @task = current_user.tasks.find_by(id: params[:id])
    if (@task == nil)
       redirect_to root_url
    end
  end

  def task_params
    params.require(:task).permit(:content, :status, :user_id)
  end
  
end
