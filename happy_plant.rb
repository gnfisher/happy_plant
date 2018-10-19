require_relative "lib/plant"
require_relative "lib/selectable_queue"

module HappyPlant
  class CLI
    def run
      system("stty raw -echo cbreak dsusp undef")

      @current_plant = HappyPlant::Plant.init

      @plant_queue = SelectableQueue.new
      @plant_queue << HappyPlant::Plant.init

      Thread.new do
        loop do
          sleep(1)
          last_state = @plant_queue.pop
          plant_queue << last_state.at_time
        end
      end

      loop do
        read, _, _ = select([STDIN, @plant_queue], nil, nil)
        if read.include?(@plant_queue)
          plant = @plant_queue.last
          puts "Queued up... Health: #{plant.health}"
        end

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
