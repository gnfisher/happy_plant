require "values"

module HappyPlant
  class Plant
    WATER_INTERVAL = 30 # seconds

    attr_reader :health, :height, :watered

    def initialize(current_plant = PlantStarter.new, health: nil, watered: nil, height: nil)
      health = health&.negative? ? 0 : health
      @health = health || current_plant.health
      @watered = watered || current_plant.watered
      @height = height || current_plant.height
    end

    def water
      health = calculate_next_health(watered: true)
      Plant.new(self, health: health, watered: Time.now, height: calculate_height(health))
    end

    def status
      Plant.new(self, health: calculate_next_health)
    end

    private

    def last_watered
      Time.now.to_i - @watered.to_i
    end

    def calculate_next_health(watered: false)
      return @health - (last_watered / WATER_INTERVAL) unless watered

      case last_watered
      when 0..20
        @health - 1
      when 21..30
        @health + 1
      when 31..Float::INFINITY
        @health - (last_watered / WATER_INTERVAL)
      end
    end

    def calculate_height(health)
      health === 10 ? @height + 1 : @height
    end

    class PlantStarter < Value.new(:health, :watered, :height)
      def initialize
        super(3, Time.now, 0)
      end
    end
  end
end
