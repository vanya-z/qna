class Reputation
  def self.calculate(object)
    object.user.reputation += 5
    object.user.save
  end
end