require 'rails_helper'

RSpec.describe "Tasks", type: :request do

  let!(:tasks) { FactoryGirl.create_list(:task, 3) }
  let(:json) { JSON.parse(response.body) }

  describe "GET /tasks" do

    before do
        get tasks_path
        expect(response).to be_success
    end

    it "should list all open tasks" do
        expect(json.collect{|l| l["status"]}).to include("Open")
    end

    it "should not list closed tasks" do
        expect(json.collect{|l| l["status"]}).not_to include("Closed")
    end
  end

  describe "GET /tasks/closed" do

    before do
        get tasks_closed_path
        expect(response).to be_success
    end

    it "should list all closed tasks" do
        expect(json.collect{|l| l["status"]}).to include("Closed")
    end

    it "should not list open tasks" do
        expect(json.collect{|l| l["status"]}).not_to include("Open")
    end
  end

  describe "GET /task/:id" do
  end

  describe "GET /task/:id/edit" do
  end

  describe "GET /task/new" do
  end

  describe "POST /task/:id" do
  end

  describe "DELETE /task/:id" do
  end

end
