class UserController < ApplicationController
  def show
    # 渲染页面
    # render 'show'
    # render action: 'show'
    # render template: 'user/show'

    # render nothing: true

    # 渲染文本/JSON
    # render plain: "OK"
    # render json: {status:'OK'}
  end
end
