module HappyPlant
  class Plant
    WATER_INTERVAL = 10 # seconds

    attr_reader :health, :height, :watered, :ancestor

    def self.create(health:, watered:, height:, ancestor: nil)
      new(health, watered, height, ancestor)
    end

    def self.init
      Plant.create(health: 3, watered: Time.now, height: 0, ancestor: nil)
    end

    def water(time = Time.now)
      last_watered = calculate_last_watered(time)
      Plant.create(health: next_health(last_watered, true), height: next_height(last_watered), watered: time, ancestor: nil)
    end

    def at_time(time = Time.now)
      last_watered = calculate_last_watered(time)
      Plant.create(health: next_health(last_watered), height: next_height(last_watered), watered: @watered, ancestor: @ancestor.nil? ? self : @ancestor)
    end

    private

    def initialize(health, watered, height, ancestor)
      @health = health
      @watered = watered
      @height = height
      @ancestor = ancestor
    end

    def calculate_last_watered(time)
      # ancesotr watered is older use ancestor watered
      time.to_i - @watered.to_i
    end

    def next_height(last_watered)
      calculate_next_health(last_watered) == 10 ? @height + 1 : @height
    end

    def next_health(last_watered, watering = false)
      next_health = if watering
                      calculate_next_health(last_watered)
                    else
                      # ancestor is nil
                      # ancestor is not nil
                      if @ancestor.nil?
                        @health - (last_watered / WATER_INTERVAL)
                      else
                        # Who knows
                        @ancestor.health - (last_watered / WATER_INTERVAL)
                      end
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
      when 0..5
        @health - 1
      when 6..10
        @health + 1
      when 11..Float::INFINITY
        @health - (last_watered / WATER_INTERVAL)
      end
    end
  end
end
