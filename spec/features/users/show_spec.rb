require 'rails_helper'

RSpec.describe 'User Show Page' do
  describe "As a visitor, when I visit /users/user_id" do
    it "I see the name of the app at the top of the page & links to all pages" do

			json_string = "{\"data\":{\"id\":\"1\",\"type\":\"user\",\"attributes\":{\"name\":\"Khoa Doe\",\"email\":\"khoa_doe@gmail.com\",\"password_digest\":\"DOESTHISEVENMATTERWHATEVERITCANBETHISORSOMETHINGELSE\",\"birthday\":\"1990-01-01\",\"phone_number\":\"123-456-7890\",\"street_address\":\"123 Main St\",\"city\":\"Las Vegas\",\"state\":\"AK\",\"zip\":\"12345\",\"drugs\":[{\"id\":1,\"rxcui\":\"12345\",\"name\":\"Tylenol\",\"synonym\":\"yes\",\"created_at\":\"2023-04-15T23:01:03.782Z\",\"updated_at\":\"2023-04-15T23:01:03.782Z\"},{\"id\":43,\"rxcui\":\"54321\",\"name\":\"Tums\",\"synonym\":\"no\",\"created_at\":\"2023-04-15T23:01:03.782Z\",\"updated_at\":\"2023-04-15T23:01:03.782Z\"}],\"user_drugs\":[{\"id\":1,\"user_id\":1,\"drug_id\":1,\"dose1\":\"2000-01-01T19:00:00.000Z\",\"dose2\":\"2056-01-01T20:00:00.000Z\",\"dose3\":\"2077-01-01T21:00:00.000Z\",\"prn\":false,\"notes\":\"Take with food\",\"created_at\":\"2023-04-15T23:01:03.782Z\",\"updated_at\":\"2023-04-15T23:01:03.782Z\"},{\"id\":21,\"user_id\":1,\"drug_id\":43,\"dose1\":\"1993-01-01T19:00:00.000Z\",\"dose2\":\"2123-01-01T20:00:00.000Z\",\"dose3\":\"40032-01-01T21:00:00.000Z\",\"prn\":true,\"notes\":\"Do a backflip WHILE you take it\",\"created_at\":\"2023-04-15T23:01:03.782Z\",\"updated_at\":\"2023-04-15T23:01:03.782Z\"}]}}}"
			user_info = JSON.pretty_generate(JSON.parse(json_string))

			stub_request(:get, "http://localhost:5000/api/v1/users/1").
			with(
				headers: {
							'Accept'=>'*/*',
							'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
							'User-Agent'=>'Faraday v2.7.4'
				}).
			to_return(status: 200, body: user_info, headers: {})
			
			visit '/users/1'

      expect(page).to have_content("WiseApp")
      expect(page).to have_link("Dashboard")
      expect(page).to have_link("MyMeds")
    end
  end
end