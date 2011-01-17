############################################################################
require 'ghaki/logger/const'

############################################################################
module Ghaki module Logger
  module Wrapper
    class Base

      #######################################################################
      attr_accessor :logger

      #######################################################################
      def initialize opts={}
        @logger = opts[:logger]
      end

      #######################################################################
      def began msg
      end

      #######################################################################
      def ended msg
      end

      #######################################################################
      def wrap msg, &block
        self.began msg
        out = block.call
        self.ended msg
        out
      end

      #######################################################################
      def wrap! msg, &block
        self.began msg
        block.call
      ensure
        self.ended msg
      end

      #######################################################################
      def wrap_if check, msg, &block
        if check
          self.wrap msg, &block
        else
          self.step msg + ' - skipping'
        end
      end

      #######################################################################
      def wrap_if! check, msg, &block
        if check
          self.wrap! msg, &block
        else
          self.step msg + ' - skipping'
        end
      end

      #######################################################################
      def step msg
      end

    end # class
  end # namespace
end end # package
############################################################################
