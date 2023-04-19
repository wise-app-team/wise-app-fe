class DrugsController < ApplicationController
  def create
    drug_params = { 
      :rxcui => params[:rxcui],
      :name => params[:name],
      :synonym => params[:synonym]
    }    
    @drug = BackendFacade.new.save_drug_to_DB(drug_params)
    # binding.pry
    # redirect_to "/users/#{params[:user_id]}/meds/new"
  end
end