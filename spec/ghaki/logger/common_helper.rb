############################################################################
require 'ghaki/logger'

############################################################################
module Ghaki module Logger
  module CommonHelper

    #---------------------------------------------------------------------
    TMP_LOG_FILE = './tmp.log'

    #---------------------------------------------------------------------
    def create_log
      @log = Ghaki::Logger::Base.new({
        :file_handle => TMP_LOG_FILE,
        :level => :debug,
      })
    end

    #---------------------------------------------------------------------
    def reset_log
      delete_log
      create_log
    end

    #---------------------------------------------------------------------
    def close_log
      @log.close unless @log.nil?
      @log = nil
    end

    #---------------------------------------------------------------------
    def delete_log
      close_log
      File.delete(TMP_LOG_FILE) if File.exists?(TMP_LOG_FILE)
    end

    #---------------------------------------------------------------------
    def slurp_log
      close_log
      @lines = IO.read(TMP_LOG_FILE).split("\n")
      @lines.shift # throw away start line
    end

  end
end end
############################################################################
