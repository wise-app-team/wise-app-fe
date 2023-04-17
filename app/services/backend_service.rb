class BackendService
  def conn 
      Faraday.new(url: "http://localhost:3000")
      
      #change to heroku url when ready
      #Faraday.new(url: "https://fierce-retreat-58631.herokuapp.com")
  end

  def save_user(user_params)
    response = conn.post('/api/v1/users')
  end

  # def show_user(user)
  #   response = conn.get("/api/v1/users/#{user.id}")
  # end

  def user_medications(user_id)
    response = conn.get("/api/v1/users/#{user_id}/meds")
    JSON.parse(response.body, symbolize_names: true)
  end
  
  def register_user
    
  end
  
  def user_create_by_oauth(auth_hash)
    response = conn.post("/api/v1/users") do |req|
      req.body = {
        user: 
        {
          name: auth_hash[:info][:name],
          email: auth_hash[:info][:email],
          password: auth_hash[:credentials][:token],
          password_confirmation: auth_hash[:credentials][:token]
        }
      }
      binding.pry
    end
  # binding.pry
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