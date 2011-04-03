require 'logger'

module Ghaki  #:nodoc:
module Logger #:nodoc:

  # Default log separator line length.
  DEF_BOX_SIZE = 76

  # Default line separator character.
  DEF_BOX_CHAR = '='

  # Default major mode log separator character.
  MAJOR_BOX_CHAR = '#'

  # Default minor mode log separator character.
  MINOR_BOX_CHAR = '*'

  # Default date time stamp log formatting.
  DEF_DATETIME_FORMAT = '%Y/%m/%d %H:%M:%S %Z'

  # Default logging level.
  DEF_LEVEL           = ::Logger::INFO

  # Lookup table for logging levels.
  # - Has strings, symbols, and ::Logger integer values.

  SEVERITY_LOOKUP = {
    ::Logger::DEBUG   => ::Logger::DEBUG,
    ::Logger::INFO    => ::Logger::INFO,
    ::Logger::WARN    => ::Logger::WARN,
    ::Logger::ERROR   => ::Logger::ERROR,
    ::Logger::FATAL   => ::Logger::FATAL,
    ::Logger::UNKNOWN => ::Logger::UNKNOWN,
    'DEBUG'   => ::Logger::DEBUG,
    'INFO'    => ::Logger::INFO,
    'WARN'    => ::Logger::WARN,
    'ERROR'   => ::Logger::ERROR,
    'FATAL'   => ::Logger::FATAL,
    'UNKNOWN' => ::Logger::UNKNOWN,
    :debug    => ::Logger::DEBUG,
    :info     => ::Logger::INFO,
    :warn     => ::Logger::WARN,
    :error    => ::Logger::ERROR,
    :fatal    => ::Logger::FATAL,
    :unknown  => ::Logger::UNKNOWN,
  }

end end
