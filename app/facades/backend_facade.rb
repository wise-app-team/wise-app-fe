class BackendFacade
  def user_medications(user_id)
    medication_data = BackendService.new.user_info(user_id)[:data][:attributes][:drugs]
    medications = medication_data.map do |medication|
      Drug.new(medication)
    end
  end

  def user_drugs_relations(user_id)
    user_drug_data = BackendService.new.user_info(user_id)[:data][:attributes][:user_drugs]
    drug_relations = user_drug_data.map do |user_drug|
      Userdrug.new(user_drug)
    end
  end
end