class DrugService
  def search_results(drug_name)
    response = conn.get("drugs.json?name=#{drug_name}")
    parsed = JSON.parse(response.body, symbolize_names: true)
  end

  def interactions_list(rxcui_list)
    response = conn.get("interaction/list.json?rxcuis=#{rxcui_list}") #rxcui_list is a string of rxcui's separated by '+' signs

    parsed = JSON.parse(response.body, symbolize_names: true)

    if response.body == "" || !parsed.keys.include?(:fullInteractionTypeGroup)
      parsed = "No interactions found."
    else
      parsed
    end
  end


  private

  def conn
    Faraday.new(url: "https://rxnav.nlm.nih.gov/REST/") 
  end
end