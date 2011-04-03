require 'ghaki/app/plugin'
require 'ghaki/logger/base'

module Ghaki  #:nodoc:
module Logger #:nodoc:

  # Create logger singleton, and link to app engine.

  class App < Ghaki::App::Plugin
    app_plugin_make Base, :logger
    app_plugin_link :logger
  end

end end
