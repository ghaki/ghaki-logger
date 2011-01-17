############################################################################
# BEGAN RUBY CLASS
############################################################################
require 'logger'

############################################################################
module Ghaki module Logger
  module CoreExt
    module LogDevice

      #---------------------------------------------------------------------
      attr_reader :shift_age, :shift_size

      #---------------------------------------------------------------------
      def rotate
        if @shift_age.is_a?(Integer) and not @filename.nil?
          @mutex.synchronize do
            shift_log_age
          end
        end
      end

      #---------------------------------------------------------------------
      def shift_age= n
        @mutex.synchronize do @shift_age = n end
      end

      #---------------------------------------------------------------------
      def shift_size= n
        @mutex.synchronize do @shift_size = n end
      end

      #---------------------------------------------------------------------
      def open_and_assign log, opts
        @filename = log
        @dev = open_logfile(@filename)
        @dev.sync = true
        @shift_age  = opts[:shift_age]
        @shift_size = opts[:shift_size]
      end

      #---------------------------------------------------------------------
      def re_open opts={}
        @mutex.synchronize do
          log = opts[:file_handle] || opts[:file_name]
          @dev = @filename = @shift_age = @shift_size = nil
          if log.respond_to?(:write) and log.respond_to?(:close)
            @dev = log
          else
            open_and_assign( log, opts )
          end
        end
      end

    end # helper
  end # namespace
end end # package
############################################################################
# ENDED RUBY CLASS
############################################################################
