class Plot < ApplicationRecord
  belongs_to :garden
  has_many :plot_plants, dependent: :destroy
  has_many :plants, through: :plot_plants

  def plot_plant_for(plant)
    PlotPlant.specific_plot_plant(id, plant)
  end
end
