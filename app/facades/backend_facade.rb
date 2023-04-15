class BackendFacade
  def user_medications(user_id)
    # binding.pry
    medication_data = BackendService.new.user_medications(user_id)
  end
end