require 'rails_helper'

RSpec.describe 'garden show page', type: :feature do
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
    @plant_4 = Plant.create!(name: "Squash", description: "Easy care, needs water and indirect light", days_to_harvest: 110)

    @plot_25.plants << @plant_1
    @plot_25.plants << @plant_3
    @plot_25.plants << @plant_4

    @plot_26.plants << @plant_3

    @plot_2.plants << @plant_2
    @plot_2.plants << @plant_4

    @plot_738.plants << @plant_1
    @plot_738.plants << @plant_2
    @plot_738.plants << @plant_3
    @plot_738.plants << @plant_4
  end

  describe 'display' do
    it 'lists all plants < 100 days_to_harvest for garden only once' do
      visit garden_path(@turing_garden.id)
      expect(page).to have_content(@plant_1.name, count: 1)
      expect(page).to have_content(@plant_3.name, count: 1)
      expect(page).to_not have_content(@plant_4.name) # days to harvest > 100
      expect(page).to_not have_content(@plant_2.name) # not in this garden at all
    end

    it 'lists plants ordered by quantity in garden' do
      visit garden_path(@turing_garden.id)
      expect(@plant_3.name).to appear_before(@plant_1.name)
    end
  end
end
