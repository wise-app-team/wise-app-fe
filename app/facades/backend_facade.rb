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

  def single_user_drug(user_id, drug_id)
    user_drugs_relations(user_id).find do |user_drug|
      user_drug.drug_id == drug_id.to_i
    end
  end

  def delete_user_drug(user_id, drug_id)
     BackendService.new.delete_user_drug(single_user_drug(user_id, drug_id).id)
  end

   def user_logging_in(user_params)
     user = BackendService.new.login_user(user_params)
   end
 end