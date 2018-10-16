require "plant"

MockPlant = Value.new(:health, :watered, :height)

RSpec.describe HappyPlant::Plant do
  it "loses health if watered within 20s of birth" do
    plant = HappyPlant::Plant.new
    expect(plant.water.health).to eq plant.health - 1
  end

  it "gains health if watered between 20s and 30s of birth" do
    plant = HappyPlant::Plant.new
    Timecop.freeze(Time.now + 25) do
      expect(plant.water.health).to eq plant.health + 1
    end
  end

  it "loses health for every interval of 30s that has passed since last watered" do
    plant = HappyPlant::Plant.new
    Timecop.freeze(Time.now + 60) do
      expect(plant.status.health).to eq plant.health - 2
    end
    Timecop.freeze(Time.now + 31) do
      expect(plant.status.health).to eq plant.health - 1
    end
  end

  it "cannot have less than 0 health" do
    plant = HappyPlant::Plant.new
    Timecop.freeze(Time.now + 180) do
      expect(plant.status.health).to eq 0
    end
  end

  it "grows by 1 if health reaches 10" do
    mock_plant = MockPlant.new(9, Time.now, 0)

    plant = HappyPlant::Plant.new(mock_plant)

    Timecop.freeze(Time.now + 30) do
      expect(plant.water.height).to eq plant.height + 1
    end
  end

  it "returns to starting health of 3 after growing" do
    mock_plant = MockPlant.new(9, Time.now, 9)

    plant = HappyPlant::Plant.new(mock_plant)

    Timecop.freeze(Time.now + 30) do
      expect(plant.water.health).to eq 3
    end
  end

  # Something to work on.
  skip "is dead if health reaches 0" do
    mock_plant = MockPlant.new(1, Time.now - 60, 0)

    plant = HappyPlant::Plant.new(mock_plant)

    Timecop.freeze do
      expect(plant.alive?).to be false
      expect(plant.water).to raise_error DeadPlantError
    end
  end
end
