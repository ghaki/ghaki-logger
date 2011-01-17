############################################################################
require 'logger'

############################################################################
module Ghaki module Logger

  MAJOR_BOX_CHAR = '#'
  MINOR_BOX_CHAR = '*'

  DEF_BOX_SIZE = 76
  DEF_BOX_CHAR = '='

  DEF_DATETIME_FORMAT = '%Y/%m/%d %H:%M:%S %Z'
  DEF_LEVEL           = ::Logger::INFO

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

end end # package
############################################################################
