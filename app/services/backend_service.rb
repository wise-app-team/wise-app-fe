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
end