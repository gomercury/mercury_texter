class Text < ApplicationRecord
	# validations
	validates :to, presence: true, phone: { possible: true }
	validates :from, presence: true, phone: { possible: true }
	validates :body, presence: true
	validates :status, null: false
end
