class MedsController < ApplicationController
  def index
    @drugs = BackendFacade.new.user_medications(params[:user_id])
    @user_drugs = BackendFacade.new.user_drugs_relations(params[:user_id])
  end
end