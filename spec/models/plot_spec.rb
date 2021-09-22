require 'rails_helper'

RSpec.describe Plot do
  before(:each) do
    @turing_garden = Garden.create!(name: 'Turing Community Garden', organic: true)
    @library_garden = Garden.create!(name: 'Public Library Garden', organic: true)
    @other_garden = Garden.create!(name: 'Main Street Garden', organic: false)
    @plot_25 = Plot.create!(number: 25, size: "Large", direction: "East", garden: @turing_garden)
    @plot_26 = Plot.create!(number: 26, size: "Small", direction: "West", garden: @turing_garden)
    @plot_2 = Plot.create!(number: 2, size: "Small", direction: "South", garden: @library_garden)
    @plot_738 = Plot.create!(number: 738, size: "Medium", direction: "West", garden: @other_garden)

    @plant_1 = Plant.create!(name: "Tomato", description: "Easy care, needs water", days_to_harvest: 40)
    @plant_2 = Plant.create!(name: "Eggplant", description: "Medium care, needs water and indirect light", days_to_harvest: 60)
    @plant_3 = Plant.create!(name: "Jalapeno", description: "Easy care, needs water and direct sun", days_to_harvest: 55)
    @plant_4 = Plant.create!(name: "Squash", description: "Easy care, needs water and indirect light", days_to_harvest: 70)


    @plot_25.plants << @plant_3
    @plot_25.plants << @plant_4
    @plot_plant_25_1 = PlotPlant.create!(plot: @plot_25, plant: @plant_1)

    @plot_2.plants << @plant_1
    @plot_plant_2_3 = PlotPlant.create!(plot: @plot_2, plant: @plant_3)
  end
  describe 'relationships' do
    it { should belong_to(:garden) }
    it { should have_many(:plot_plants) }
    it { should have_many(:plants).through(:plot_plants) }
  end

  describe 'instance methods' do
    it 'finds plot_plant for specific plant' do
      expect(@plot_25.plot_plant_for(@plant_1.id)).to eq(@plot_plant_25_1)
      expect(@plot_2.plot_plant_for(@plant_3.id)).to eq(@plot_plant_2_3)
    end
  end
end
