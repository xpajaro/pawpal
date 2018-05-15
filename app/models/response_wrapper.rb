class ResponseWrapper
  def initialize(d, s="SUCCESS", m=nil)
    @data = d
    @status = s
    @message = m
  end
end