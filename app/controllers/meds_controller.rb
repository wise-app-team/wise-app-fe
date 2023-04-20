class MedsController < ApplicationController
  def index
    @user_id = params[:user_id]
    @drugs = BackendFacade.new.user_medications(params[:user_id])
    @user_drugs = BackendFacade.new.user_drugs_relations(params[:user_id])
    @interactions = DrugsFacade.new.interactions_list(@drugs.map(&:rxcui).join('+'))
    if params[:search].present?
      @all_drugs_searched = DrugsFacade.new.search_results(params[:search])
    else
      @all_drugs_searched = []
    end
    # require 'pry'; binding.pry
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
end