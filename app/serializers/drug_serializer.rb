#from internet: 
# class DrugSerializer
#   include FastJsonapi::ObjectSerializer
#   attributes :name, :description, :created_at, :updated_at
# end

# class DrugSerializer

#   attributes :name, :synonym

#   def self.format_drugs(drugs)
#     { data: drugs.map do |drug|
#               {
#                 id: drug.id.to_s,
#                 attributes: {
#                   name: drug.name,
#                   synonym: drug.synonym
#                 }
#               }
#             end }
#   end
# end
