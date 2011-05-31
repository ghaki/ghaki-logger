require 'logger'
require 'forwardable'

module Ghaki   #:nodoc:
module Logger  #:nodoc:
module CoreExt #:nodoc:

  # Adds features to the <b>Logger</b> class.

  module Logger
    extend Forwardable

    attr_accessor :logdev

    def_delegators :@logdev,
      :shift_age,
      :shift_age=,
      :shift_size,
      :shift_size=,
      :filename

    # Calls <b>LogDevice</b> for log rotation.

    def rotate
      @logdev.rotate
      self
    end

    # Calls <b>LogDevice</b> for re-opening the log file.

    def re_open opts={}
      @logdev.re_open opts
      self
    end

    # Re-opens <b>$stderr</b> with the current log file. 

    def re_stderr
      @logdev.re_stderr
      self
    end

    # Re-opens <b>$stdout</b> with the current log file.

    def re_stdout
      @logdev.re_stdout
      self
    end

    # Re-opens standard files with the current log file.

    def re_stds
      @logdev.re_stds
      self
    end

  end
end end end
