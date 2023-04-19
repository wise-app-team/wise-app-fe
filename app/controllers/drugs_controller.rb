class DrugsController < ApplicationController
  def new
    drug_params = { 
      :rxcui => params[:rxcui],
      name => params[:name],
      synonym => params[:synonym]
    }    
    binding.pry
    @drug = BackendFacade.new.save_drug_to_DB(drug_params)
  end
end