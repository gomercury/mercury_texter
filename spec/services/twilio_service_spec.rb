require 'rails_helper'

RSpec.describe TwilioService, type: :service do
	before(:each) do
		DatabaseCleaner.strategy = :truncation
		DatabaseCleaner.clean
	end

	describe ".send_text" do
		context "when text has valid 'to' and 'from' phone numbers" do
			it "should update text 'status' to 'succeeded'" do
				text = FactoryGirl.create(:text,
					to: 	"4159303829",
					from: "5005550006",
				)
				text = TwilioService.send_text(text)
				expect(text.status).to eq("succeeded")
				expect(text.error).to be_nil
			end
		end

		context "when text has invalid 'to' phone number" do
			it "should update text 'status' to 'failed'" do
				text = FactoryGirl.create(:text,
					to: 	"0000000000",
					from: "5005550006",
				)
				text = TwilioService.send_text(text)
				expect(text.status).to eq("failed")
				expect(text.error).to_not be_nil
			end
		end

		context "when text has invalid 'from' phone number" do
			it "should update text 'status' to 'failed'" do
				text = FactoryGirl.create(:text,
					to: 	"5005550006",
					from: "0000000000",
				)
				text = TwilioService.send_text(text)
				expect(text.status).to eq("failed")
				expect(text.error).to_not be_nil
			end
		end
	end
end
