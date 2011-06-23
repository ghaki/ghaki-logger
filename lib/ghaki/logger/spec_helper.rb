require 'ghaki/logger/base'
require 'stringio'

module Ghaki      #:nodoc:
module Logger     #:nodoc:
module SpecHelper #:nodoc:

  DEF_CLASS = Ghaki::Logger::Base

  def make_safe_logger klass=DEF_CLASS, opts={}
    fname = opts.delete(:file_name)
    handl = opts.delete(:file_handle)
    obj = klass.new(opts.merge({
      :file_handle => StringIO.new,
    })
    obj.stub( :file_name => fname, :filename => fname ) unless fname.nil?
    obj.stub( :file_handle => handl ) unless handl.nil?
    obj.stub( :re_stds )
    obj.stub( :re_stderr )
    obj.stub( :re_stdout )
    obj
  end

  def setup_safe_logger klass=DEF_CLASS, opts={}
    @logger = make_safe_logger(klass,opts)
  end

end end end
