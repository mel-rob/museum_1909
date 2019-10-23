class Museum

  attr_reader :name, :exhibits, :patrons

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def recommended_exhibits(patron)
    @exhibits.find_all do |exhibit|
      patron.interests.any? { |interest| exhibit.name.include?(interest) }
    end
  end

  def admit(patron)
    @patrons << patron
  end

  def interests_by_patron(exhibit)
    @patrons.find_all do |patron|
      patron.interests.include?(exhibit)
    end
  end


  def patrons_by_exhibit_interest
    @exhibits.collect do |exhibit|
      hash[exhibit] = interests_by_patron(exhibit)
    end
  end
end
