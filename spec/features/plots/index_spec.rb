require 'rails_helper'

RSpec.describe 'index page for plots', type: :feature do
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

    @plot_25.plants << @plant_1
    @plot_25.plants << @plant_3
    @plot_25.plants << @plant_4

    @plot_2.plants << @plant_1
    @plot_2.plants << @plant_3

    @plot_26.plants << @plant_2
    @plot_26.plants << @plant_4

    @plot_738.plants << @plant_1
    @plot_738.plants << @plant_2
    @plot_738.plants << @plant_3
    @plot_738.plants << @plant_4
  end

  describe 'plot and plants display' do
    it 'shows plot numbers and their plants' do
      visit '/plots'
      within("#plots-#{@plot_25.id}") do
        expect(page).to have_content("##{@plot_25.number}")
        expect(page).to have_content(@plant_1.name)
        expect(page).to have_content(@plant_3.name)
        expect(page).to have_content(@plant_4.name)
        expect(page).to_not have_content(@plant_2.name)
      end
      within("#plots-#{@plot_26.id}") do
        expect(page).to have_content("##{@plot_26.number}")
        expect(page).to have_content(@plant_2.name)
        expect(page).to have_content(@plant_4.name)
        expect(page).to_not have_content(@plant_1.name)
        expect(page).to_not have_content(@plant_3.name)
      end
      within("#plots-#{@plot_2.id}") do
        expect(page).to have_content("##{@plot_2.number}")
        expect(page).to have_content(@plant_1.name)
        expect(page).to have_content(@plant_3.name)
        expect(page).to_not have_content(@plant_2.name)
        expect(page).to_not have_content(@plant_4.name)
      end
      within("#plots-#{@plot_738.id}") do
        expect(page).to have_content("##{@plot_738.number}")
        expect(page).to have_content(@plant_1.name)
        expect(page).to have_content(@plant_3.name)
        expect(page).to have_content(@plant_2.name)
        expect(page).to have_content(@plant_4.name)
      end
    end
  end
end
