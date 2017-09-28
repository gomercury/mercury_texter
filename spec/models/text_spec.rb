require 'rails_helper'

RSpec.describe Text, type: :model do
	it "should have a valid factory" do
		text = FactoryGirl.create(:text)
		expect(text).to be_valid
	end
end
