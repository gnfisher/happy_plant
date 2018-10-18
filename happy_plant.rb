require_relative "lib/plant"

module HappyPlant
  class CLI
    def run
      system("stty raw -echo cbreak dsusp undef")

      @current_plant = HappyPlant::Plant.init

      loop do
        read, _, _ = select([STDIN], nil, nil)
        if read.include?(STDIN)
          key = STDIN.getc
          case key
          when ?q
            raise SystemExit
          when ?w
            @current_plant = @current_plant.water
            puts "Health: #{@current_plant.health}"
          when ?c
            @current_plant = @current_plant.at_time
            puts "Health: #{@current_plant.health}"
          end
        end
      end
    end
  end
end

# ruby happy_plant.rb
#

HappyPlant::CLI.new.run
