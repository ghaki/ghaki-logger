require 'forwardable'

require 'ghaki/logger/const'
require 'ghaki/logger/core_ext'
require 'ghaki/logger/liner'
require 'ghaki/logger/wrapper/major'
require 'ghaki/logger/wrapper/minor'

module Ghaki  #:nodoc:
module Logger #:nodoc:

class Base < ::Logger
  include Ghaki::Logger::Liner

  attr_accessor \
    :major, # helper for major logging info mode
    :minor  # helper for minor logging info mode

=begin rdoc

== Constructor options:

[+box_char+]        Character used to make line separators in the logs.
[+box_size+]        Line length used for separators in the logs.
[+datetime_format+] Date/time format used for logging.
[+file_handle+]     Open file handle to log to.
[+file_name+]       Name of file to open for logging.
[+level+]           Verbosity of logging.
[+shift_age+]       Shift age for logs, see ::Logger:: for details.
[+shift_size+]      Shift size for logs, see ::Logger for details.

=end

  def initialize opts={}

    setup_liner opts

    @major = Ghaki::Logger::Wrapper::Major.new({
      :logger   => self,
      :box_char => opts[:box_char],
      :box_size => opts[:box_size],
    })

    @minor = Ghaki::Logger::Wrapper::Minor.new({
      :logger => self,
    })

    if opts[:log_device].nil?
      super( *([
        opts[:file_handle] || opts[:file_name] || $stderr,
        opts[:shift_age],
        opts[:shift_size]
      ].compact) )
    else
      super(nil)
      self.logdev = opts[:log_device]
    end

    self.level = opts[:level] || DEF_LEVEL
    self.datetime_format = opts[:datetime_format] || DEF_DATETIME_FORMAT
  end

  # Set logging level. Assert on invalid level.

  def level= val
    val = SEVERITY_LOOKUP[val]
    raise ArgumentError, "Invalid log level: #{val}" if val.nil?
    super(val)
  end

  # Create similar logger that uses the same log device.

  def dup
    Ghaki::Logger::Base.new({
      :log_device      => self.logdev,
      :level           => self.level,
      :datetime_format => self.datetime_format,
      :shift_age       => self.shift_age,
      :shift_size      => self.shift_size,
      :box_char        => self.box_char,
      :box_size        => self.box_size,
    })
  end

end
end end
