class DrugsFacade
  def search_results(drug_name)
    search_results = service.search_results(drug_name)
    final = search_results[:drugGroup][:conceptGroup][1][:conceptProperties].map do |drug|
      Drug.new(drug)
    end
  end

  def interactions_list(rxcui_list)
    interactions_list = service.interactions_list(rxcui_list)
    if interactions_list == "No interactions found."
      [Interaction.new(:description => interactions_list)]
    else
      final = interactions_list[:fullInteractionTypeGroup].map do |group|
        group[:fullInteractionType].map do |type|
          Interaction.new(type[:interactionPair][0])
        end
      end.flatten
    end
  end

  private
  def service
    @service ||= DrugService.new
  end
end