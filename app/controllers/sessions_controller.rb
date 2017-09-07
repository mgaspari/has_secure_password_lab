class SessionsController < ApplicationController
  def new
  end

  def create
    if params[:user][:name] == nil || params[:user][:name] == "" || params[:user][:password] == nil || params[:user][:password] == ""
      redirect_to '/sessions/new'
    else
      @user = User.find_by(name: params[:user][:name])
      return head(:forbidden) unless @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to '/'
    end
  end

  def destroy
    if session[:user_id]
      session.delete :user_id
    end
    redirect_to '/sessions/new'
  end
end
