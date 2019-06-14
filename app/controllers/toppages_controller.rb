class ToppagesController < ApplicationController
  def index
    
    
    if logged_in?
      unless @current_user.name == nil
      
      # 現在時刻の取得(9～33の範囲)
        #標準時の時間のみ整数として取得し、日本時刻に調整
        @current_time = Time.now.strftime('%H').to_i + 9
        if (@current_time>=29 && @current_time<=33) || (@current_time>=9 && @current_time<=12) 
          @message = 'おはようございます'
        elsif (@current_time >= 13 && @current_time <= 18)  
          @message = 'こんにちは'
        elsif (@current_time >= 19 && @current_time <= 28) 
          @message = 'こんばんは'
        end
        
      # ログインユーザ名の取得(ユーザ名登録時)
        @name = @current_user.name + "さん"
      else
      # ログインユーザ名の取得(ユーザ名が未登録)  
        @name = "ユーザーさん"
      end 
      
      @task = Task.new
      @tasks = @current_user.tasks.where('status >= 0 && status <=4' )
      @done_tasks = @current_user.tasks.where('status >= 5')
    end 
  end
end

