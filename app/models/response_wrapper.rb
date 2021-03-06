class ResponseWrapper
  RESPONSE_PASS = "SUCCESS"
  RESPONSE_FAIL = "ERROR"

  attr_accessor :data, :status, :message

  def initialize(d, s=RESPONSE_PASS, m=nil)
    @data = d
    @status = s
    @message = m
  end
end