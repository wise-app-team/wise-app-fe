class Drug
  attr_accessor :id,
                :name, 
                :synonym,
                :rxcui

  def initialize(drug)
    @id = drug[:id]
    @name = drug[:name]
    @synonym = drug[:synonym]
    @rxcui = drug[:rxcui]
  end
end