############################################################################
require 'ghaki/logger/wrapper/base'

############################################################################
module Ghaki module Logger
  module Wrapper
    class Minor < Base

      #######################################################################
      def began msg
        logger.info 'began ' + msg
      end

      #######################################################################
      def ended msg
        logger.info 'ended ' + msg
      end

      #######################################################################
      def step msg
        logger.info 'step ' + msg
      end

    end # helper
  end # namespace
end end # package
############################################################################
