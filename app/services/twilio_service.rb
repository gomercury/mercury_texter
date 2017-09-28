class TwilioService
	def self.send_text(text)
		begin
			# create twilio client
			account_sid = Rails.application.secrets.account_sid
			auth_token = Rails.application.secrets.auth_token
			client = Twilio::REST::Client.new account_sid, auth_token

			# send text
			response = client.api.account.messages.create(
				from: text.from,
				to: 	text.to,
				body: text.body,
			)
			text.status = "succeeded"
		rescue Twilio::REST::RestError => error
			text.status = "failed"
			text.error = error
		end
		text.save
		return text
	end
end
