class Interaction
  attr_accessor :severity,
                :description

  def initialize(interaction)
    @severity = interaction[:severity]
    @description = interaction[:description]
  end
end