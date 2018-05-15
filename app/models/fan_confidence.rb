class FanConfidence
  attr_accessor :catFanConfidence, :dogFanConfidence

  def initialize(c=0.0, d=0.0)
    @catFanConfidence = c.to_f
    @dogFanConfidence = d.to_f
  end
end