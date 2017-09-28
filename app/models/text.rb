class Text < ApplicationRecord
	# validations
	validates :to, presence: true, phone: { possible: true }
	validates :from, presence: true, phone: { possible: true }
	validates :body, presence: true
	validates :status, presence: true

	# scopes
	scope :pending, -> { where(status: "pending") }
	scope :failed, -> { where(status: "failed") }
end
