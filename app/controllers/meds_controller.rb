class MedsController < ApplicationController
  def index
    @user_id = params[:user_id]
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
    drug_id = BackendFacade.new.find_drug_id_by_rxcui(params[:rxcui])
    user_drug_params = {
      :user_id => params[:user_id],
      :drug_id => drug_id[:data][:id],
      :dose1 => params[:dose1],
      :dose2 => params[:dose2],
      :dose3 => params[:dose3],
      :prn => params[:prn],
      :notes => params[:notes]
    }
    @user_drug = BackendFacade.new.save_drug_to_user(user_drug_params)
  end

  def new
    @medication_name = params[:synonym]
    @user_id = params[:user_id]
  end
end