require 'ghaki/logger/core_ext/logdev'
require 'ghaki/logger/core_ext/logger'

class Logger # :nodoc:
  include Ghaki::Logger::CoreExt::Logger
  class LogDevice
    include Ghaki::Logger::CoreExt::LogDevice
  end
end
