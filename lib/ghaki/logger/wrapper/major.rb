############################################################################
require 'ghaki/logger/wrapper/base'

############################################################################
module Ghaki module Logger
  module Wrapper
      class Major < Base

      ######################################################################
      attr_accessor :box_char, :box_size

      ######################################################################
      def initialize opts={} ; super opts
        @box_char = opts[:box_char] || MAJOR_BOX_CHAR
        @box_size = opts[:box_size] || DEF_BOX_SIZE
      end

      ######################################################################
      def began msg, box_char=@box_char, box_size=@box_size
        logger.liner box_char, box_size
        logger.info 'BEGAN ' + msg
        logger.liner box_char, box_size
      end

      ######################################################################
      def ended msg, box_char=@box_char, box_size=@box_size
        logger.liner box_char, box_size
        logger.info 'ENDED ' + msg
        logger.liner box_char, box_size
      end

      ######################################################################
      def step msg
        logger.info 'STEP ' + msg
      end

    end # helper
  end # namespace
end end # package
############################################################################
