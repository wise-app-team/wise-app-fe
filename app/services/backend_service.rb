class BackendService

  def conn 
      Faraday.new(url: "http://localhost:3000")
      
      #change to heroku url when ready
      #Faraday.new(url: "https://fierce-retreat-58631.herokuapp.com")
  end

  def save_user(user_params)
    response = conn.post('/api/v1/users') do |req|
      req.body = user_params
    end
  end
  
  def register_user
    
  end
  
  # def self.user_create_or_find(params)
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