require 'rails_helper'

RSpec.describe "Tasks", type: :request do

  let!(:tasks) { FactoryGirl.create_list(:task, 3) }
  let(:json) { JSON.parse(response.body) }

  describe "GET /tasks" do
    it "should list all open tasks" do
        get root_path
        expect(response).to have_http_status(200)
        tasks.each do |task|
            expect(json.collect{|l| l["title"]}).to include(task.title)
        end
    end
  end
end
