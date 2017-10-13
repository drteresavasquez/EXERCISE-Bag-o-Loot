require 'support/number_helper'
class ChildLootBags
    include NumberHelper

      @@filepath = nil

      def self.filepath=(path=nil)
        @@filepath = File.join(APP_ROOT, path)
      end
      
      attr_accessor :toy, :child

      def self.file_exists?
        # class should know if the restaurant file exists
        if @@filepath && File.exists?(@@filepath)
            return true
        else
            return false
        end
      end
      
      def self.file_useable?
        return false unless @@filepath
        return false unless File.exists?(@@filepath)
        return false unless File.readable?(@@filepath)
        return false unless File.writable?(@@filepath)
        return true
      end

      def self.create_file
        # create the restaurant file
        File.open(@@filepath, 'w') unless file_exists?
        return file_useable?
      end
      
      def self.saved_lootbags
        # read the lootbag file
        childbags = []
        if file_useable?
            file = File.new(@@filepath, 'r')
            file.each_line do |line|
                childbags << ChildLootBags.new.import_line(line.chomp)
            end
            file.close
        end
        # return instances of childbags
        return childbags
      end

    def initialize(args={})
      @toy = args[:toy] || ""
      @child = args[:child] || ""
    end

    def import_line(line)
        line_array = line.split("\t")
        @toy, @child = line_array
        return self
    end

    def self.build_using_questions
        args = {}
        print "What is the Toy? "
        args[:toy] = gets.chomp.upcase.strip
        
        print "What is the name of the child getting this toy? "
        args[:child] = gets.chomp.upcase.strip
        
        return self.new(args)
    end

      def save
        return false unless ChildLootBags.file_useable?
        File.open(@@filepath, 'a') do |file|
            file.puts "#{[@toy, @child].join("\t")}\n"
        end
        return true
      end

      def formatted_price
        
      end
end