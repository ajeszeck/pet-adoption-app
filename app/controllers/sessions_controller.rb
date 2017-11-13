class SessionsController < ApplicationController
  def new
    render "new"
  end

  def create
    @user = User.find_by(email: params[:email]).try(:authenticate, params[:password])
    if @user != nil
      session[:user_id] = @user.id
      redirect_to root_path
    else
      @errors = ["Incorrect combination of username/password."]
      render "new"
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end


end
