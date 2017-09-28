namespace :texts do
	desc "send texts via twilio api"
	task send: :environment do
		log = ActiveSupport::Logger.new('log/texts_send.log')
		start_time = Time.now
		log.info "texts:send task started at #{start_time}"

		texts = Text.pending
		log.info "#{texts.count} pending #{'text'.pluralize(texts.count)} to send..."
		texts.each do |text|
			log.info "sending text #{text.id}"
			text = TwilioService.send_text(text)
			log.info "text #{text.id} #{text.status}"
		end

		texts = Text.failed
		log.info "#{texts.count} failed #{'text'.pluralize(texts.count)} to send..."
		texts.each do |text|
			log.info "sending text #{text.id}"
			text = TwilioService.send_text(text)
			log.info "text #{text.id} #{text.status}"
		end

		end_time = Time.now
		duration = (start_time - end_time) / 1.minute
		log.info "texts:send task finished at #{end_time} and lasted #{duration} minutes"
		log.close
	end
end
