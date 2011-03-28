############################################################################
require 'ghaki/app/plugin'
require 'ghaki/logger/base'

module Ghaki module Logger

  class App < Ghaki::App::Plugin
    create_engine_plugin :logger, Base
    link_engine_to_plugin
  end # class 

end end # package
