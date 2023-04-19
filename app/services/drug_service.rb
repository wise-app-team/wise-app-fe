class DrugService
  def search_results(drug_name)
    response = conn.get("drugs.json?name=#{drug_name}")
    parsed = JSON.parse(response.body, symbolize_names: true)
  end

  private

  def conn
    Faraday.new(url: "https://rxnav.nlm.nih.gov/REST/") 
  end
end