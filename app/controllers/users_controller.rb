class UsersController < ApplicationController



  def logout
  end

  def registration_select
  end

  def complete
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to root
    # @task = Task.find(params[:id])
    # @task.update(task_params)
    # redirect_to @task
  end

end
