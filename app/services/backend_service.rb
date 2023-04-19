class BackendService
  def conn 
      Faraday.new(url: "http://localhost:5000")
      
      #change to heroku url when ready
      #Faraday.new(url: "https://fierce-retreat-58631.herokuapp.com")
  end

  def save_user(user_params)
    response = conn.post('/api/v1/users') do |req|
			req.body = user_params
		end
  end

  # def save_user_drug(user_drug_params)
  #   conn.post('/api/v1/user_drugs') do |req|
  #     req.body = user_drug_params
  #   end
  # end

  def save_drug(drug_params)
    conn.post('/api/v1/drugs') do |req|
      req.body = drug_params
    end
  end

   def delete_user_drug(user_drug_id)
     conn.delete("/api/v1/user_drugs/#{user_drug_id}") 
   end

  def login_user(user_params)
    response = conn.post('/api/v1/users/login') do |req|
      req.body = user_params
    end
  end

  # def show_user(user)
  #   response = conn.get("/api/v1/users/#{user.id}")
  # end

  def user_info(user_id)
    response = conn.get("/api/v1/users/#{user_id}")
    JSON.parse(response.body, symbolize_names: true)
  end
 
  
  def user_create_by_oauth(auth_hash)
    response = conn.post("/api/v1/users") do |req|
      req.body = {
        user: 
        {
          name: auth_hash[:info][:name],
          email: auth_hash[:info][:email],
          token: auth_hash[:credentials][:token],
					provider: auth_hash[:provider]
          # password_confirmation: auth_hash[:credentials][:token]
        }
      }
    end
  end
  
  # def user_create_or_find(params)
  #   binding.pry
  #   if params.length > 3
  #     connection.post('/api/v1/users') do |req|
  #       req.body = {user: params}
  #     end
  #   else
  #     connection.get("/api/v1/users/#{params[:ID]}") do |req|
  #       req.headers = params
  #     end
  #   end
  # end
end