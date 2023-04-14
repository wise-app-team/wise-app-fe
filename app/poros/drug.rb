class Drug
  attr_accessor :name, 
                :synonym,
                :rxcui

  def initialize(drug)
    @name = drug[:name]
    @synonym = drug[:synonym]
    @rxcui = drug[:rxcui]
  end
end