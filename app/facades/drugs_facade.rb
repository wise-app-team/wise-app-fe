class DrugsFacade
  def search_results(drug_name)
    search_results = service.search_results(drug_name)
    search_results[:drugGroup][:conceptGroup][1][:conceptProperties].map do |drug|
      Drug.new(drug)
    end
  end

  private
  def service
    @service ||= DrugService.new
  end
end