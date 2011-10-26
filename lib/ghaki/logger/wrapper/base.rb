require 'ghaki/logger/const'

module Ghaki   #:nodoc:
module Logger  #:nodoc:
module Wrapper #:nodoc:

# Base wrapping logging class.

class Base

  attr_accessor :logger

  def initialize opts={}
    @logger = opts[:logger]
  end

  # Print a processing begins info message.

  def began msg
  end

  # Print a processing ends info message.

  def ended msg
  end

  # Print a processing step info message.

  def step msg
  end

  # Wrap a code block with begin / end messages.
  # End message <b>will not</b> be printed if an exception is reached.

  def wrap msg, &block
    self.began msg
    out = block.call
    self.ended msg
    out
  end

  # Wrap a code block with begin / end messages.
  # End message <b>will</b> be printed if an exception is reached.

  def wrap! msg, &block
    self.began msg
    block.call
  ensure
    self.ended msg
  end

  # Wrap a code block with a begin/end message, unless the check evaluates as false.
  # If the check is false, print a skipping step info log message.
  # End message <b>will not</b> be printed if an exception is reached.

  def wrap_if check, msg, &block
    if check
      self.wrap msg, &block
    else
      self.step msg + ' - skipping'
    end
  end

  # Wrap a code block with a begin/end message, unless the check evaluates as false.
  # If the check is false, print a skipping step info log message.
  # End message <b>will</b> be printed if an exception is reached.

  def wrap_if! check, msg, &block
    if check
      self.wrap! msg, &block
    else
      self.step msg + ' - skipping'
    end
  end

end
end end end
