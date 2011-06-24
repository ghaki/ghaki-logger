require 'ghaki/logger/null'

module Ghaki      #:nodoc:
module Logger     #:nodoc:
module SpecHelper #:nodoc:

  def make_safe_logger opts={}
    Ghaki::Logger::Null.new( opts )
  end

  def setup_safe_logger opts={}
    @logger = make_safe_logger(klass,opts)
  end

end end end
