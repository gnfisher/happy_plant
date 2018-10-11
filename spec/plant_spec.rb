require "plant"

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
end
