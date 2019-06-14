class TasksController < ApplicationController
  
  before_action :whether_or_not_logged_in
  
  def index
    #　@current_time, @messageの再取得
    #　標準時の時間のみ整数として取得し、日本時刻に調整
    @current_time = Time.now.strftime('%H').to_i + 9
    if (@current_time>=29 && @current_time<=33) || (@current_time>=9 && @current_time<=12) 
      @message = 'おはようございます'
    elsif (@current_time >= 13 && @current_time <= 18)  
      @message = 'こんにちは'
    elsif (@current_time >= 19 && @current_time <= 28) 
      @message = 'こんばんは'
    end
      
    # @nameの再取得
    unless @current_user.name == nil
      @name = @current_user.name + "さん"
    else
      @name = "ユーザーさん"
    end 
    
    # link_toからクリックされたタグを取得,絞り込みと再表示
    #:tasklist_tag_nameにタグ絞り込みがあった場合
    if params[:tasklist_tag_name]
      @done_tasks = @current_user.tasks.where('status >= 5')
      # @tasksもタグで絞り込みした上で再定義
      @tasks = Task.tagged_with("#{params[:tasklist_tag_name]}").where('status >= 0 && status <=4' )
      render 'toppages/index'
      
      #:checklist_tag_nameにタグ絞り込みがあった場合
      elsif params[:checklist_tag_name]
        @tasks = @current_user.tasks.where('status >= 0 && status <=4' )
        @done_tasks = Task.tagged_with("#{params[:checklist_tag_name]}").where('status >= 5')
        render 'toppages/index'
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
