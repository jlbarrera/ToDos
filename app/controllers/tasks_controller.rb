class TasksController < ApplicationController
    def index
        @tasks = Task.where(status: 'Open').order("created_at DESC")
        render :json => @tasks
    end

    def show
        @tasks = Task.find(params[:id])
    end

    def closed
        @tasks = Task.where(status: 'Closed').order("created_at DESC")
        render :json => @tasks
    end
end
