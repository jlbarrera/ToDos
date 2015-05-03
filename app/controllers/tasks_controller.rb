class TasksController < ApplicationController
    def index
        @tasks = Task.where(status: 'Open').order("created_at DESC")
        render :json => @tasks
    end

    def show
        @task = Task.find(params[:id])
        render :json => @task

        rescue ActiveRecord::RecordNotFound
            render :json => {:error => "The task doesn't exist"}
    end

    def create
        @task = Task.new(task_params)
        @task.save
        render :json=> @task
    end

    def destroy
        @task = Task.find(params[:id])
        @task.destroy
        render :json => {:success => "The task have been deleted"}

        rescue ActiveRecord::RecordNotFound
            render :json => {:error => "The task doesn't exist"}
    end

    def closed
        @tasks = Task.where(status: 'Closed').order("created_at DESC")
        render :json => @tasks
    end

    def all
        @tasks = Task.order("created_at DESC").all
        render :json => @tasks
    end

    def task_params
        params.require(:task).permit(:title, :content, :status)
    end
end