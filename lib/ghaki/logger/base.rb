############################################################################
require 'delegate'
require 'ghaki/logger/const'
require 'ghaki/logger/core_ext'
require 'ghaki/logger/deprecated'
require 'ghaki/logger/liner'
require 'ghaki/logger/wrapper/major'
require 'ghaki/logger/wrapper/minor'

############################################################################
module Ghaki module Logger
  class Base < DelegateClass(::Logger)

    ########################################################################
    include Ghaki::Logger::Liner
    include Ghaki::Logger::Deprecated

    ########################################################################
    attr_accessor :major, :minor, :raw_log

    ########################################################################
    def initialize opts={}

      setup_liner opts

      @major = Ghaki::Logger::Wrapper::Major.new({
        :logger   => self,
        :box_char => opts[:major_char],
        :box_size => opts[:major_size],
      })

      @minor = Ghaki::Logger::Wrapper::Minor.new({
        :logger => self,
      })

      @raw_log = ::Logger.new( *( [
               opts[:file_handle] || opts[:file_name] || $stderr,
               opts[:shift_age],
               opts[:shift_size]
                ].compact) )

      super( @raw_log )

      self.level           = opts[:level] || DEF_LEVEL
      self.datetime_format = opts[:datetime_format] || DEF_DATETIME_FORMAT
    end

    ########################################################################
    def level= val
      val = SEVERITY_LOOKUP[val]
      raise ArgumentError, "Invalid log level: #{val.to_s}", caller if val.nil?
      super( val )
    end

  end # class
end end # package
############################################################################
