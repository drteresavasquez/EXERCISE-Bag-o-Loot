require 'child'
require 'support/string_extend'
class Lootbag
    
    class Config
        @@actions = ["list", "remove", "add", "find", "quit"]
        def self.actions; @@actions; end
    end


      def initialize(path=nil)
        # locate the lootbag text file at path
        ChildLootBags.filepath = path
        if ChildLootBags.file_useable?
            puts "Found ChildLootBags File."
        # or create a new file
        elsif ChildLootBags.create_file
            puts "Created ChildLootBags File."
        # exit if create fails
        else 
            puts "Exiting. \n\n"
            exit!
        end
      end
    
      def launch!
        introduction
        # action loop
        result = nil
        until result == :quit do
            action, args = get_action
            result = do_action(action, args)
        end
        conclusion
      end

      def get_action
        action = nil
        # Keep asking for user input until they input a valid action
        until Lootbag::Config.actions.include?(action)
            # what do you want to do? (list, remove, add, find a kid, quit)
            puts "Stuff You Can Do: " + Lootbag::Config.actions.join(", ") if action
            print "> "
            user_response = gets.chomp
            args = user_response.downcase.strip.split(' ')
            action = args.shift
        end
        return action, args
      end
    
      def do_action(action, args=[])
        case action
        when 'list'
            list
        when 'remove'
            # keyword = args.shift
            remove
        when 'add'
            add
        when 'quit'
            return :quit
        when 'find'
            keyword = args.shift
            find(keyword)
        else
            puts "I don't understant that command"
        end
      end

      def remove
        output_action_header("Delete a Kid")
        args = {}
        print "What is the Toy? "
        args[:toy] = gets.chomp.upcase.strip
        
        print "Name of the child? "
        args[:child] = gets.chomp.upcase.strip

        if args
            childlootbag = ChildLootBags.saved_lootbags
            found = childlootbag.select do |bags|
                bags.toy.downcase.include?(args[:toy].downcase) && 
                bags.child.downcase.include?(args[:child].downcase) 
            end

            puts "No lootbags found with #{args[:toy]} going to #{args[:child]}" if found.empty?
            puts "Trying to Delete #{args[:toy]} from #{args[:child]}." unless found.empty?
        end
      end

      def find(keyword="")
        output_action_header("Find a Kid")
        if keyword
            childlootbag = ChildLootBags.saved_lootbags
            found = childlootbag.select do |bags|
                bags.child.downcase.include?(keyword.downcase)
            end
            output_lootbag_table(found)
        else
            puts "Find a child by inputting their name."
            puts "Example: 'find Chris', 'find Mel' \n\n"
        end
      end

      def list()
        output_action_header("Listing Children's Loot Bags!")
        childlootbag = ChildLootBags.saved_lootbags
        output_lootbag_table(childlootbag)
        # childlootbag.each do |bag|
        #     puts bag.toy + "|" + bag.child
        # end
      end


      def add
        output_action_header("Add a Child's Loot Bag!")
        childlootbag = ChildLootBags.build_using_questions
        if childlootbag.save
            puts "Lootbag Added!"
        else
            puts "SAVE ERROR: Lootbag not added"
        end
      end

      def introduction
        puts "\n\n<<< Welcome to the Loot Bag Generator! >>>\n\n"
        puts "This is an interactive guide to help generate loot bags for the not so naughty children this year.\n\n"
      end
    
        def conclusion
          puts "\n<<< Goodbye and Remember to be Nice! >>>\n\n\n"
        end

        private

        def output_action_header(text)
            puts "\n#{text.upcase.center(60)}\n\n"
        end

        def output_lootbag_table(childlootbag=[])
            print " " + "TOY".ljust(33)
            print " " + "CHILD".ljust(24) + "\n"
            puts "-" * 60
            childlootbag.each do |bag|
              line =  " " << bag.toy.titleize.ljust(33)
              line << " " + bag.child.titleize.ljust(24)
              puts line
            end
            puts "No lootbags found" if childlootbag.empty?
            puts "-" * 60
        end
        
end
    