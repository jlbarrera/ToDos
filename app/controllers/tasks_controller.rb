class TasksController < ApplicationController
    def index
        @tasks = Task.order("created_at DESC").all
        render :json => @tasks
    end
end
