module Api
	module V1
		class TextsController < ApplicationController
			include ActionController::HttpAuthentication::Token::ControllerMethods
			before_action :restrict_access
			respond_to :json

			def create
				text = Text.create(
					to: params[:to],
					from: params[:from],
					body: params[:body],
				)
				render json: text
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
