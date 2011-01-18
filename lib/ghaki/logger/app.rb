############################################################################
require 'singleton'
require 'ghaki/logger/base'

############################################################################
module Ghaki module Logger
  class App
    include Singleton

    #---------------------------------------------------------------------
    DEF_LOGGER_OPTS = {}

    #---------------------------------------------------------------------
    attr_writer :logger, :logger_opts

    #---------------------------------------------------------------------
    def logger
      @logger ||= Ghaki::Logger::Base.new( self.logger_opts )
    end

    #---------------------------------------------------------------------
    def logger_opts
      @logger_opts ||= DEF_LOGGER_OPTS.dup
    end

  end # class 
end end # package
############################################################################

############################################################################
begin
  require 'ghaki/app/engine'
  Ghaki::App::Engine.class_eval do
    def logger      ; Ghaki::Logger::App.instance.logger       end
    def logger= val ; Ghaki::Logger::App.instance.logger = val end

    def logger_opts      ; Ghaki::Logger::App.instance.logger_opts       end
    def logger_opts= val ; Ghaki::Logger::App.instance.logger_opts = val end
  end
rescue LoadError
end
############################################################################
