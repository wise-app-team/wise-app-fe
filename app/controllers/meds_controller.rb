class MedsController < ApplicationController
  def index
    # require 'pry'; binding.pry
    @user_id = params[:user_id]
    @drugs = BackendFacade.new.user_medications(params[:user_id]) # good
    @user_drugs = BackendFacade.new.user_drugs_relations(params[:user_id]) # good
    
    rxcuis = @drugs.map(&:rxcui).join('+')
    if rxcuis.include?("+")
      @interactions = DrugsFacade.new.interactions_list(@drugs.map(&:rxcui).join('+'))
    else
      @interactions = []
    end
    
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

    redirect_to "/users/#{params[:user_id]}/meds"
  end

  def new
    # binding.pry
 
    @medication_name = params[:synonym]
    @rxcui = params[:rxcui].to_s
    @user_id = params[:user_id]
  end

  private
  def meds_params
    params.permit(:rxcui)
  end
end