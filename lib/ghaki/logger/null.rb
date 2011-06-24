require 'ghaki/logger/base'
require 'stringio'

module Ghaki  #:nodoc:
module Logger #:nodoc:

class Null < Base

  attr_accessor :allow_redirection
  alias_method :allow_redirection?, :allow_redirection
  
=begin rdoc

== Constructor options:

[+allow_redirection+] Allow redirection of STDOUT and STDERR. [default:false]

=end

  def initialize _opts={}
    opts = _opts.dup
    @allow_redirection = opts.delete(:allow_redirection)
    opts.delete(:log_device)
    opts.delete(:file_handle)
    opts[:file_handle] = StringIO.new
    @keep_fname = opts.delete(:file_name)
    super( opts )
  end

  # Return captured filename.
  def filename
    @keep_fname
  end
  alias_method :file_name, :filename

  # Reassign STDOUT and STDERR but only if redirection is allowed.
  def re_stds
    super if @allow_redirection
  end

  # Reassign STDERR but only if redirection is allowed.
  def re_stderr
    super if @allow_redirection
  end

  # Reassign STDOUT but only if redirection is allowed.
  def re_stdout
    super if @allow_redirection
  end

end
end end