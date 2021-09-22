class Garden < ApplicationRecord
  has_many :plots
  has_many :plot_plants, through: :plots
  has_many :plants, through: :plot_plants

  def quick_plants
    plants.where('days_to_harvest < ?', 100)
    .select('plants.*, COUNT(plants.*) AS plant_count')
    .group('plants.id')
    .order('plant_count DESC')
  end
end
