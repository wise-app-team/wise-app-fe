class MedsController < ApplicationController
  def index
    @all_drugs_searched = DrugsFacade.new.search_results(params[:search])
    @drugs = BackendFacade.new.user_medications(params[:user_id])
    @user_drugs = BackendFacade.new.user_drugs_relations(params[:user_id])
    @drug_search_results = DrugsFacade.new.search_results(params[:search])
  end

  def edit
    @drug = BackendFacade.new.user_medications(params[:user_id]).find do |drug|
      drug.id == params[:id].to_i
    end

    @user_drug = BackendFacade.new.user_drugs_relations(params[:user_id]).find do |user_drug|
      user_drug.id == params[:id].to_i
    end

    @user_id = params[:user_id]
    @medications = BackendFacade.new.user_medications(params[:user_id])
  end

  def destroy
    BackendFacade.new.delete_user_drug(params[:user_id], params[:id])
    redirect_to "/users/#{params[:user_id]}/meds"
  end

  def create
    @all_drugs_searched = DrugsFacade.new.search_results(params[:search])
    binding.pry
  end

  def new
    @medication_name = params[:synonym]
    @user_id = params[:user_id]
  #   drug_params = { 
  #     :rxcui => params[:rxcui],
  #     :name => params[:name],
  #     :synonym => params[:synonym]
  #   }    
  #   @drug = BackendFacade.new.save_drug_to_DB(drug_params)
  #   redirect_to "/users/#{params[:user_id]}/meds/new"
  end
end