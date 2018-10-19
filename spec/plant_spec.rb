require "plant"

RSpec.describe HappyPlant::Plant do
  it "loses health if watered within 5s of birth" do
    plant = HappyPlant::Plant.init

    result = plant.water(Time.now + 4)

    expect(result.health).to eq plant.health - 1
  end

  it "gains health if watered between 5s and 10s of birth" do
    plant = HappyPlant::Plant.init

    result = plant.water(Time.now + 8)

    expect(result.health).to eq plant.health + 1
  end

  it "loses health for every interval of 10s that has passed since last watered" do
    plant = HappyPlant::Plant.init

    result = plant.water(Time.now + 20)

    expect(result.health).to eq plant.health - 2
  end

  it "cannot have less than 0 health" do
    plant = HappyPlant::Plant.create(health: 1, height: 1, watered: Time.now)

    result = plant.at_time(Time.now + 180)

    expect(result.health).to eq 0
  end

  it "grows by 1 if health reaches 10" do
    plant = HappyPlant::Plant.create(health: 9, height: 0, watered: Time.now)

    result = plant.water(Time.now + 9)

    expect(result.height).to eq plant.height + 1
  end

  it "returns to starting health of 3 after growing" do
    plant = HappyPlant::Plant.create(health: 9, height: 0, watered: Time.now)

    result = plant.water(Time.now + 30)

    expect(result.health).to eq 3
    expect(result.height).to eq plant.height + 1
  end

  it "when checked ancestor remains same as ancestor's ancestor" do
    plant = HappyPlant::Plant.create(health: 9, height: 0, watered: Time.now)
    watered_plant = plant.water(plant.watered + 8)

    result = watered_plant.at_time(plant.watered + 10)

    expect(watered_plant.ancestor).to eq result.ancestor
  end

  # Broken bad test!
  it "it properly deducts health with multiple #at_time checks" do
    start_time = Time.now
    plant1 = HappyPlant::Plant.create(health: 4, height: 0, watered: start_time)
    plant2 = plant1.at_time(start_time + 2)
    waterme = plant2.water(start_time + 3)

    result = waterme.at_time(start_time + 5)

    expect(result.health).to eq 3
  end

  # Something to work on.
  skip "is dead if health reaches 0" do
    plant = HappyPlant::Plant.create(health: 1, height: 0, watered: Time.now)

    result = plant.at_time(Time.now + 30)

    expect(result.health).to eq 0
    expect(result.alive?).to be false
  end
end
