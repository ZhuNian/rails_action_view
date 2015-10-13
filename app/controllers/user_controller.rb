class UserController < ApplicationController
  def show
    redirect_to user_add_url

    # render 'add'
  end
end
