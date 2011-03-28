############################################################################
require 'ghaki/app/mixer'
require 'ghaki/logger/app'

############################################################################
module Ghaki module Logger

  module Mixin
    extend Ghaki::App::Mixer
    create_plugin_mixin :logger, Ghaki::Logger::App
  end # helper
  
end end # package
############################################################################
