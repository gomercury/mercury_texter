FactoryGirl.define do
	factory :text do
		to 		 "4159303829"
		from 	 "5005550006"
		body 	 Faker::RickAndMorty.quote
	end
end
