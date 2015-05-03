require 'rails_helper'

RSpec.describe TasksController, type: :controller do

    describe "Creating new Task" do

        let!(:task) { FactoryGirl.create(:task) }

        it "should increment the tasks count" do
            expect{ post :create, task: FactoryGirl.attributes_for(:task) }.to change{ Task.count }.by(1)
        end

        it "should respond with success" do
            post :create, task: FactoryGirl.attributes_for(:task)
            expect(response).to be_success
        end
    end

end
