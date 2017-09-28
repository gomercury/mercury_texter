require 'rails_helper'

RSpec.describe Api::V1::TextsController, type: :controller do
	before(:each) do
		allow(controller).to receive(:restrict_access)
	end

	describe "POST create" do
		context "with valid attributes" do
			it "creates a new text" do
				expect {
					post :create, params: FactoryGirl.attributes_for(:text)
				}.to change(Text, :count).by(1)
				expect(response).to have_http_status(:created)
				expect(JSON.parse(response.body)["status"]).to eq("pending")
			end
		end

		context "with invalid 'to' attribute" do
			it "does not save new text" do
				expect {
					post :create, params: FactoryGirl.attributes_for(:text, to: "invalid number")
				}.to_not change(Text, :count)
				expect(response).to have_http_status(:bad_request)
				expect(JSON.parse(response.body)["errors"]).to_not be_nil
			end
		end

		context "with invalid 'from' attribute" do
			it "does not save new text" do
				expect {
					post :create, params: FactoryGirl.attributes_for(:text, from: "invalid number")
				}.to_not change(Text, :count)
				expect(response).to have_http_status(:bad_request)
				expect(JSON.parse(response.body)["errors"]).to_not be_nil
			end
		end

		context "with invalid 'body' attribute" do
			it "does not save new text" do
				expect {
					post :create, params: FactoryGirl.attributes_for(:text, body: nil)
				}.to_not change(Text, :count)
				expect(response).to have_http_status(:bad_request)
				expect(JSON.parse(response.body)["errors"]).to_not be_nil
			end
		end
	end
end
