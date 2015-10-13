class UserController < ApplicationController
  def show
    redirect_to user_add_url

    # render 'add'
  end

  def add
    @users = User.find_by(id:1)
  end

  def form
    render partial: 'form', locals:{email_text:params[:email_text]}
  end
end
