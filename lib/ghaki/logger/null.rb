require 'ghaki/logger/base'
require 'stringio'

module Ghaki  #:nodoc:
module Logger #:nodoc:

class Null < Base

  def initialize _opts={}
    opts = _opts.dup
    @keep_handl = opts.delete(:file_handle)
    @keep_fname = opts.delete(:file_name)
    opts.delete(:log_device)
    opts[:file_handle] = StringIO.new
    super( opts )
  end

  def filename
    @keep_fname
  end
  alias_method :file_name, :filename

  def file_handle
    @keep_handle
  end

  def re_stds
  end

  def re_stderr
  end

  def re_stdout
  end

end
end end
