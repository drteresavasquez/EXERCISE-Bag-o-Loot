require 'minitest/autorun'
require_relative 'lootbag'


class LootBagTest < MiniTest::Test

    # def setup
    #     @lootBag = LootBagTest.new
    # end

    def can_setup_a_loot_bag
        lootbag = Lootbag.new
    end


end









# Items can be added to bag, and assigned to a child.

# f4 = File.open("new_yaml.yaml", "w+")
# #dump = write
# f4.puts YAML::dump("Test")
# f4.close


# Items can be removed from bag, per child. Removing ball from the bag should not be allowed. A child's name must be specified.
# Must be able to list all children who are getting a toy.
# Must be able to list all toys for a given child's name.
# Must be able to set the delivered property of a child, which defaults to false to true.

# def test_toys_for_child_can_be_added_to_bag
#     lootBag = Bag.new
#     lootBag.add_toy_for_child("kite", "suzy")
#     assert_equal("kite", lootBag.child_items("suzy")[0])
# end


# create_loot_bag("add", "kite", "suzy")
# remove_from_loot_bag("remove", "suzy", "kite")