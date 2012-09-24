class UsersController < ApplicationController
  skip_before_filter :username_check?

  def update
    @user = User.find(params[:id])
    if not @user.update_attributes(params[:user])
      render 'first_edit'
    else
      redirect_to(root_url)
    end
  end

  def first_edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end
end
