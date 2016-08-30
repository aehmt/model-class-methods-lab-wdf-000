class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    all.group("classifications.id")
  end

  def self.longest
    Boat.all.joins(:classifications).order("length DESC").limit(1)[0].classifications
  end
end
