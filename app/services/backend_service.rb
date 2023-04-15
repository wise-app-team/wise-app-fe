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

  def show_user(user)
    response = conn.get("/api/v1/users/#{user}")
  end

  def user_medications(user_id)
    response = conn.get("/api/v1/users/#{user_id}/medical")
    JSON.parse(response.body, symbolize_names: true)
  end
end