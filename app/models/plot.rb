class Plot < ApplicationRecord
  belongs_to :garden
  has_many :plot_plants, dependent: :destroy
  has_many :plants, through: :plot_plants

  def plot_plant_for(plant)
    plot_plants.where('plant_id = ?', plant).first
  end
end
