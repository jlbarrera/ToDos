require 'rails_helper'

RSpec.describe "Tasks", type: :request do

  let!(:tasks) { FactoryGirl.create_list(:task, 3) }
  let(:json) { JSON.parse(response.body) }

  describe "GET /tasks" do
    it "should list all open tasks" do
        get tasks_path
        expect(json.collect{|l| l["status"]}).not_to include("Close")
    end
  end

  describe "GET /tasks/closed" do
    it "should list all closed tasks" do
        get tasks_closed_path
        expect(json.collect{|l| l["status"]}).not_to include("Open")
    end
  end

end
