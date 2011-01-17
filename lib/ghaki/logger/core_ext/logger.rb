############################################################################
# BEGAN RUBY CLASS
############################################################################
require 'logger'
require 'forwardable'

############################################################################
module Ghaki module Logger
  module CoreExt
    module Logger
      extend Forwardable

      #---------------------------------------------------------------------
      def_delegators :@logdev,
        :shift_age,  :shift_age=,
        :shift_size, :shift_size=,
        :filename

      #---------------------------------------------------------------------
      def re_stds
        re_stderr
        re_stdout
      end

      #---------------------------------------------------------------------
      def rotate
        @logdev.rotate
        self
      end

      #---------------------------------------------------------------------
      def re_open opts={}
        @logdev.re_open opts
        self
      end

      #---------------------------------------------------------------------
      def re_stderr
        $stderr.reopen(@logdev.dev)
        self
      end

      #---------------------------------------------------------------------
      def re_stdout
        $stdout.reopen(@logdev.dev)
        self
      end

    end # helper
  end # namespace
end end # package
############################################################################
# ENDED RUBY CLASS
############################################################################
