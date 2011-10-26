require 'ghaki/logger/wrapper/base'

module Ghaki   #:nodoc:
module Logger  #:nodoc:
module Wrapper #:nodoc:

# Minor mode for info logging.
class Minor < Base

  # Log that the minor process began.

  def began msg
    logger.info 'began ' + msg
  end

  # Log that the major process ended.

  def ended msg
    logger.info 'ended ' + msg
  end

  # Log the minor process step.

  def step msg
    logger.info 'step ' + msg
  end

end
end end end
