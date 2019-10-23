require 'minitest/autorun'
require 'minitest/pride'
require './lib/exhibit'
require './lib/patron'
require './lib/museum'


class MuseumTest < Minitest::Test

  def setup
    @dmns = Museum.new("Denver Museum of Nature and Science")
    @gems_and_minerals = Exhibit.new("Gems and Minerals", 0)
    @dead_sea_scrolls = Exhibit.new("Dead Sea Scrolls", 10)
    @imax = Exhibit.new("IMAX", 15)

    @bob = Patron.new("Bob", 20)
    @sally = Patron.new("Sally", 20)
  end

  def test_it_exists
    assert_instance_of Museum, @dmns
  end

  def test_it_initializes
    assert_equal "Denver Museum of Nature and Science", @dmns.name
    assert_equal [], @dmns.exhibits
  end

  def test_it_has_exhibits
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)

    assert_equal [@gems_and_minerals, @dead_sea_scrolls, @imax], @dmns.exhibits
  end

  def test_it_can_recommend_exhibits
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@imax)

    @bob.add_interest("Dead Sea Scrolls")
    @bob.add_interest("Gems and Minerals")

    assert_equal [@dead_sea_scrolls, @gems_and_minerals], @dmns.recommended_exhibits(@bob)

    @sally.add_interest("IMAX")
    assert_equal [@imax], @dmns.recommended_exhibits(@sally)
  end

  def test_it_can_accept_patrons

    assert_equal [], @dmns.patrons

    @dmns.admit(@bob)
    @dmns.admit(@sally)

    assert_equal [@bob, @sally], @dmns.patrons
  end

  def test_it_can_see_interests_by_patron
    @dmns.admit(@bob)
    @bob.add_interest("Dead Sea Scrolls")

    assert_equal [@bob], @dmns.interests_by_patron("Dead Sea Scrolls")
  end


  def test_it_can_return_patrons_by_exhibit_interest
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@imax)

    @dmns.admit(@bob)
    @dmns.admit(@sally)

    @bob.add_interest("Dead Sea Scrolls")
    @bob.add_interest("Gems and Minerals")
    @sally.add_interest("IMAX")

    expected_hash = {
                      @dead_sea_scrolls => @bob,
                      @gems_and_minerals => @bob,
                      @imax => @sally
                    }

    assert_equal expected_hash, @dmns.patrons_by_exhibit_interest
  end
end
