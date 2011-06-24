require 'ghaki/logger/spec_helper'

require File.join(File.dirname(__FILE__),'../..','mocha_helper')

module Ghaki module Logger module SpecHelper_Testing
describe SpecHelper do
  include SpecHelper

  describe '#make_safe_logger' do
    it 'returns null logger' do
      make_safe_logger.should be_an_instance_of(Null)
    end
  end

  describe '#setup_safe_logger' do
    it 'creates null logger instance variable' do
      setup_safe_logger
      defined?(@logger).should be_true
    end
  end

end
end end end
