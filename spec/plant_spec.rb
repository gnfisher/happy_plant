require "plant"

RSpec.describe HappyPlant::Plant do
  it "loses health if watered within 20s of birth" do
    plant = HappyPlant::Plant.init

    result = plant.water(Time.now + 19)

    expect(result.health).to eq plant.health - 1
  end

  it "gains health if watered between 20s and 30s of birth" do
    plant = HappyPlant::Plant.init

    result = plant.water(Time.now + 25)

    expect(result.health).to eq plant.health + 1
  end

  it "loses health for every interval of 30s that has passed since last watered" do
    plant = HappyPlant::Plant.init

    result = plant.water(Time.now + 60)

    expect(result.health).to eq plant.health - 2
  end

  it "cannot have less than 0 health" do
    plant = HappyPlant::Plant.create(health: 1, height: 1, watered: Time.now)

    result = plant.at_time(Time.now + 180)

    expect(result.health).to eq 0
  end

  it "grows by 1 if health reaches 10" do
    plant = HappyPlant::Plant.create(health: 9, height: 0, watered: Time.now)

    result = plant.water(Time.now + 30)

    expect(result.height).to eq plant.height + 1
  end

  it "returns to starting health of 3 after growing" do
    plant = HappyPlant::Plant.create(health: 9, height: 0, watered: Time.now)

    result = plant.water(Time.now + 30)

    expect(result.health).to eq 3
    expect(result.height).to eq plant.height + 1
  end

  # Something to work on.
  skip "is dead if health reaches 0" do
    plant = HappyPlant::Plant.create(health: 1, height: 0, watered: Time.now)

    result = plant.at_time(Time.now + 30)

    expect(result.health).to eq 0
    expect(result.alive?).to be false
  end
end
