class Captain < ActiveRecord::Base
  has_many :boats

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorboaters
    includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end

  def self.catamaran_operators
    all.joins(boats: :classifications).where("classifications.name = 'Catamaran'").group("captains.id")
  end

  def self.sailors
    all.joins(boats: :classifications).where("classifications.name = 'Sailboat'").group("captains.id")
  end

  def self.talented_seamen
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboaters.pluck(:id))
  end
  
  def self.non_sailors
    where("id NOT IN (?)", self.sailors.pluck(:id))
  end
end
