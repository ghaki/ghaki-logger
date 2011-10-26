require 'ghaki/logger/wrapper/base'

module Ghaki   #:nodoc:
module Logger  #:nodoc:
module Wrapper #:nodoc:

# Major mode for info logging.
class Major < Base

  # Accessors for dealing with the line creation.

  attr_accessor :box_char, # Character used to make line separators in the logs.
    :box_size # Line length used for separators in the logs.

=begin rdoc

== Constructor options:

[+box_char+]  Character used to make line separators in the logs.
[+box_size+]  Line length used for separators in the logs.

=end
  def initialize opts={} ; super opts
    @box_char = opts[:box_char] || MAJOR_BOX_CHAR
    @box_size = opts[:box_size] || DEF_BOX_SIZE
  end

  # Log that the major process began.

  def began msg, box_char=@box_char, box_size=@box_size
    logger.liner box_char, box_size
    logger.info 'BEGAN ' + msg
    logger.liner box_char, box_size
  end

  # Log that the major process ended.

  def ended msg, box_char=@box_char, box_size=@box_size
    logger.liner box_char, box_size
    logger.info 'ENDED ' + msg
    logger.liner box_char, box_size
  end

  # Log the major proecss step.

  def step msg
    logger.info 'STEP ' + msg
  end

end
end end end
