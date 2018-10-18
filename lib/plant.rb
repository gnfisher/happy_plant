module HappyPlant
  class Plant
    WATER_INTERVAL = 30 # seconds

    attr_reader :health, :height, :watered

    def self.create(health:, watered:, height:)
      new(health, watered, height)
    end

    def self.init
      Plant.create(health: 3, watered: Time.now, height: 0)
    end

    def water(time = Time.now)
      last_watered = calculate_last_watered(time)
      Plant.create(health: next_health(last_watered, true), height: next_height(last_watered), watered: time)
    end

    def at_time(time = Time.now)
      last_watered = calculate_last_watered(time)
      Plant.create(health: next_health(last_watered), height: next_height(last_watered), watered: @watered)
    end

    private

    def initialize(health, watered, height)
      @health = health
      @watered = watered
      @height = height
    end

    def calculate_last_watered(time)
      time.to_i - @watered.to_i
    end

    def next_height(last_watered)
      calculate_next_health(last_watered) == 10 ? @height + 1 : @height
    end

    def next_health(last_watered, watering = false)
      next_health = if watering
                      calculate_next_health(last_watered)
                    else
                      @health - (last_watered / WATER_INTERVAL)
                    end
      if next_health == 10
        3
      elsif next_health < 0
        0
      else
        next_health
      end
    end

    def calculate_next_health(last_watered)
      case last_watered
      when 0..20
        @health - 1
      when 21..30
        @health + 1
      when 31..Float::INFINITY
        @health - (last_watered / WATER_INTERVAL)
      end
    end
  end
end
