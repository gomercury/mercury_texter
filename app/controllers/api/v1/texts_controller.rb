module Api
	module V1
		class TextsController < ApplicationController
			include ActionController::HttpAuthentication::Token::ControllerMethods
			before_action :restrict_access
			respond_to :json

			def create
				text = Text.new(text_params)
				text.from = Rails.application.secrets.number
				if text.save
					render status: 201, json: {
						status: 201,
						text: text,
					}
				else
					render status: 400, json: { 
						status: 400,
						errors: text.errors.full_messages,
					}
				end
			end
			
			private

				def restrict_access
					authenticate_or_request_with_http_token do |token, options|
						ApiKey.exists?(access_token: token)
					end
				end

				def text_params
					params.require(:text).permit(:to, :from, :body)
				end
		end
	end
end
