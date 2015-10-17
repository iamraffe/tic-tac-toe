class Player
  attr_reader :symbol, :name, :is_human

  def initialize(symbol, name, is_human = false)
    @symbol = symbol
    @name = name
  end
end