class MedicalController < ApplicationController
  def index
    @medications = BackendFacade.new.user_medications(params[:user_id])
  end
end