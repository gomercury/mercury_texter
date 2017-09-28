require 'rails_helper'

RSpec.describe Text, type: :model do
	it "should have a valid factory" do
		text = FactoryGirl.create(:text)
		expect(text).to be_valid
	end

	describe ".pending" do
		it "should return texts with 'pending' status" do
			pending_text = FactoryGirl.create(:text, status: "pending")
			failed_text = FactoryGirl.create(:text, status: "failed")
			texts = Text.pending
			expect(texts.count).to eq(1)
			expect(texts.first).to eq(pending_text)
		end
	end

	describe ".failed" do
		it "should return texts with 'failed' status" do
			pending_text = FactoryGirl.create(:text, status: "pending")
			failed_text = FactoryGirl.create(:text, status: "failed")
			texts = Text.failed
			expect(texts.count).to eq(1)
			expect(texts.first).to eq(failed_text)
		end
	end
end
