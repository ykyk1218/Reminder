class TasksController < ApplicationController
  
  before_action :whether_or_not_logged_in
  
  def index
    # link_toからクリックされたタグを取得し、同名のタグ含むタグを@tasksとして格納
    if params[:tag_name]
      @tasks = Task.tagged_with("#{params[:tag_name]}")
      # binding.pry
      # この後ページを再表示するにはrenderメソッドを使ってタグを再表示する？
    end 
  
  end 
  
  def new
    @task = Task.new
    render 'tasks/register'
  end

  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      # flash[:success] = "カードを作成しました!"
      redirect_to root_url
    else 
      flash[:danger] = "カード作成に失敗しました"
      render :register
    end 
  end
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def update 
    @task = Task.find(params[:id])
    
    if @task.update(task_params)
      # flash[:success] = "カードを更新しました!"
      redirect_to root_url 
    else
      flash[:danger] = "カード編集に失敗しました"
      render :register
    end 
    
  end 

  def destroy
  end
  

  
  def done
    # binding.pry
    params[:task].update(status: 5)
  end 
  
  private 
  
  def task_params
    params.require(:task).permit(:title, :content, :tag_list, :status)
  end 
  
end
