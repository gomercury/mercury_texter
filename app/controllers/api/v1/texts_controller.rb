module Api
	module V1
		class TextsController < ApplicationController
			include ActionController::HttpAuthentication::Token::ControllerMethods
			before_action :restrict_access
			respond_to :json

			def create
				text = Text.new(
					to: params[:to],
					from: params[:from],
					body: params[:body],
				)
				if text.save
					render status: :created, json: text
				else
					render status: :bad_request
				end
			end
			
			private

				def restrict_access
					authenticate_or_request_with_http_token do |token, options|
						ApiKey.exists?(access_token: token)
					end
				end
		end
	end
end
