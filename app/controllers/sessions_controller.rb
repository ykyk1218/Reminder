class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:sessions][:email].downcase 
    password =params[:sessions][:password]
    
    if authentication(email, password)
      flash[:success] = "ログインに成功しました"
      redirect_to root_url 
    else 
      flash.now[:danger] = "ログインに失敗しました"
      render :new 
    end 
    
  end

  def destroy
    session[:user_id] = nil 
    flash[:success] = "ログアウトしました"
    redirect_to root_url
  end
  
  private
  
  def authentication(input_email, input_password)
    @user = User.find_by(email: input_email)
    
    if @user && @user.authenticate(input_password)
      session[:user_id] = @user.id 
      return true 
    else 
      return false
    end 
  end 
  
end
