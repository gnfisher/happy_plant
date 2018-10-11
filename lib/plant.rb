require "values"

module HappyPlant
  class Plant
    attr_reader :health, :watered

    def initialize(current_plant = NilPlant.new, health: nil, watered: nil)
      @health = health || current_plant.health
      @watered = watered || current_plant.watered
    end

    def water
      case last_watered
      when 0..20
        health = @health - 1
      when 21..30
        health = @health + 1
      when 31..Float::INFINITY
        health = @health - (last_watered / 30)
      end

      health = health.negative? ? 0 : health
      HappyPlant::Plant.new(self, health: health, watered: Time.now)
    end

    def status
      HappyPlant::Plant.new(self, health: calculate_next_health)
    end

    private

    def last_watered
      Time.now.to_i - @watered.to_i
    end

    def calculate_next_health
      next_health = @health - last_watered / 30
      next_health.negative? ? 0 : next_health
    end

    class NilPlant < Value.new(:health, :watered)
      def initialize
        super(3, Time.now)
      end
    end
  end
end
