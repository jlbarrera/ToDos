require 'rails_helper'

RSpec.describe "Tasks", type: :request do

  let!(:tasks) { FactoryGirl.create_list(:task, 3) }
  let(:json) { JSON.parse(response.body) }

  describe "GET /tasks" do

    before do
        get tasks_path
        expect(response).to be_success
    end

    it "should have all open tasks" do
        tasks.each do |task|
            if task.status.eql?("Open")
                expect(json.collect{|l| l["title"]}).to include(task.title)
            end
        end
    end

    it "should not have any closed tasks" do
        expect(json.collect{|l| l["status"]}).not_to include("Closed")
    end
  end

  describe "GET /tasks/closed" do

    before do
        get tasks_closed_path
        expect(response).to be_success
    end

    it "should have all closed tasks" do
        tasks.each do |task|
            if task.status.eql?("Closed")
                expect(json.collect{|l| l["title"]}).to include(task.title)
            end
        end
    end

    it "should not have any open tasks" do
        expect(json.collect{|l| l["status"]}).not_to include("Open")
    end
  end

  describe "GET /tasks/all" do

    before do
        get tasks_all_path
        expect(response).to be_success
    end

    it "should have all tasks" do
        tasks.each do |task|
            expect(json.collect{|l| l["title"]}).to include(task.title)
        end
        expect(json.count).to match(3)
    end
  end

  describe "GET /task/:id" do

    let!(:task) { tasks.first }

    context "valid task" do
        before do
            get task_path task
            expect(response).to be_success
        end

        it "should have task info" do
            expect(json["title"]).to eq(task.title)
        end

        it "should not have any other task" do
            expect(json.kind_of?(Array)).to eq(false)
        end
    end

    context "invalid task" do

        before do
            get task_path(99)
            expect(response).to be_success
        end

        it "should alert us about the error" do
            expect(json["error"]).to eq("The task doesn't exist")
        end
    end
  end


  describe "POST /tasks" do

    let!(:task) { FactoryGirl.create(:task) }

    context "with valid data" do

        before do
            @task_attributes = FactoryGirl.attributes_for(:task)
            post "/tasks", :task => @task_attributes
            expect(response).to be_success
        end

        it "should have the new task info" do
            expect(json["title"]).to eq(@task_attributes[:title])
        end

        it "should not have any other task" do
            expect(json.kind_of?(Array)).to eq(false)
        end
    end

  end

  describe "DELETE /task/:id" do

    let!(:task) { tasks.first }

    context "with valid data" do
        before do
            delete "/tasks/#{task.id}"
            expect(response).to be_success
        end

        it "should confirm us that the task have been deleted" do
            expect(json["success"]).to eq("The task have been deleted")
        end
    end

    context "with not valid data" do
        before do
            delete "/tasks/99"
            expect(response).to be_success
        end

        it "should alert about the error" do
            expect(json["error"]).to eq("The task doesn't exist")
        end
    end
  end

end
