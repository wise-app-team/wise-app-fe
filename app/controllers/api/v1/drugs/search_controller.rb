class Api::V1::Drugs::SearchController < ApplicationController
	def find_all
		drugs = DrugsFacade.new.search_results(params[:name])

		if drugs.empty?
			render json: { error: 'No drugs found' }, status: 404
		else
			render json: DrugSerializer.format_drugs(drugs)
		end
	end
end