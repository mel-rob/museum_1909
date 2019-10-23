class Museum

  attr_reader :name, :exhibits

  def initialize(name)
    @name = name
    @exhibits = []
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def recommended_exhibits(patron)
    @exhibits.find_all do |exhibit|
      patron.interests.any? { |interest| exhibit.name.include?(interest) }
    end
  end
end
