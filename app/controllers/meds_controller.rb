class MedsController < ApplicationController
  def index
    @drugs = BackendFacade.new.user_medications(params[:user_id])
    @user_drugs = BackendFacade.new.user_drugs_relations(params[:user_id])
    @drug_search_results = DrugFacade.new.search_results(params[:search])
  end

  def edit
    @drug = BackendFacade.new.user_medications(params[:user_id]).find do |drug|
      drug.id == params[:id].to_i
    end

    @user_drug = BackendFacade.new.user_drugs_relations(params[:user_id]).find do |user_drug|
      user_drug.id == params[:id].to_i
    end

    @user_id = params[:user_id]
  end
end