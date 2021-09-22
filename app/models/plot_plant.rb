class PlotPlant < ApplicationRecord
  belongs_to :plot
  belongs_to :plant

  def self.specific_plot_plant(plot, plant)
    where('plot_id = ? AND plant_id = ?', plot, plant).last
  end
end
