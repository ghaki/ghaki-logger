require 'logger'

module Ghaki   #:nodoc:
module Logger  #:nodoc:
module CoreExt #:nodoc:

  # Adds features to the <b>LogDevice</b> class.

  module LogDevice

    attr_reader \
      :shift_age,    # Exposes getter for <b>shift_age</b>.
      :shift_size    # Exposes getter for <b>shift_size</b>.

    # Exposes setter for <b>shift_age</b>.

    def shift_age= n
      @mutex.synchronize do @shift_age = n end
    end

    # Exposes setter for <b>shift_size</b>.

    def shift_size= n
      @mutex.synchronize do @shift_size = n end
    end

    # Forces log rotation.

    def rotate
      if @shift_age.is_a?(Integer) and not @filename.nil?
        @mutex.synchronize do
          shift_log_age
        end
      end
    end

    # Reopen the logger using the new opts.

    def re_open opts={}
      @mutex.synchronize do
        log = opts[:file_handle] || opts[:file_name]
        @dev = @filename = @shift_age = @shift_size = nil
        if log.respond_to?(:write) and log.respond_to?(:close)
          @dev = log
        else
          _open_and_assign( log, opts )
        end
      end
    end

    protected

    def _open_and_assign log, opts #:nodoc:
      @filename = log
      @dev = open_logfile(@filename)
      @dev.sync = true
      @shift_age  = opts[:shift_age]
      @shift_size = opts[:shift_size]
    end

  end
end end end
