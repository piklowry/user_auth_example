class GithubController < ApplicationController

	def authenticate
		redirect_uri = github_auth_callback_url
		scope = "gist"
		state = set_random_state

		redirect_to "https://github.com/login/oauth/authorize?client_id=#{client_id}&redirect_uri=#{redirect_uri}&scope=#{scope}&state=#{state}"
	end

	def callback
		if params[:state] == session[:state]
		get_access_token(params[:code])
		redirect_to wishlists_path, notice: "github hooked up!"
	else
		redirect_to wishlists_path, notice: "authorization failed"
	end
end


# this is for the form on the front page
def create_gist
	url = "https://api.github.com/gists"
	hash = {description: params[:description], "public" => true, "files" => {params[:title] => {"content" => params[:content] }}}

	response = HTTParty.post(url, {body: hash.to_json, headers: {"User-Agent" => "class auth app", "Authorization" => "token #{current_user.github_token}"} })

	redirect_to :back, notice: "gist created"

	# body is the information of the request


	end

	private

	def get_access_token(code)
		begin

		clent_secret = Rails.application.secrets.github_secret

		options = {client_id: client_id, client_secret: client_secret, code: code}
		response = HTTParty.post("https://github.com/login/oauth/access_token", body: options)

		# debugger how to grab the token in the easiest way
		# puts response 
		token = parse_response(response.parsed_response)
		current_user.github_token = token
		current_user.save!
	rescue
		raise
	 end
	end


		# resp = response.parsed_response
		# array1 = resp.slit("=")
		# array2 = 
		# token = array2[0]


	def parsed_response(response)
		array1 = response.split("=")
		array2 = array1[1].split("&")
		array2[0]
	end

	def client_id
		client_id ||= Rails.application.secrets.github_id
	end

	def set_random_state
		session[:state] = Digest::SHA256.hexdigest("#{current_user.id}:#{SecureRandom.hex}")
	end



end

