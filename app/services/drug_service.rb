class DrugService
  def search_results(drug_name)
    response = conn.get("drugs.json?name=#{drug_name}")
    parsed = JSON.parse(response.body, symbolize_names: true)
  end

  def interactions_list(rxcui_list)
    # binding.pry
    response = conn.get("interaction/list.json?rxcuis=#{rxcui_list}") #rxcui_list is a string of rxcui's separated by '+' signs

    
    if response.body == ""
      parsed = "No interactions found."
    else
      parsed = JSON.parse(response.body, symbolize_names: true)

      if !parsed.keys.include?(:fullInteractionTypeGroup)
        parsed = "No interactions found."
      else
        parsed
      end

    end
  end


  private

  def conn
    Faraday.new(url: "https://rxnav.nlm.nih.gov/REST/") 
  end
end