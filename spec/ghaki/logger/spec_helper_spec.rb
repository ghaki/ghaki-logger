require 'ghaki/logger/spec_helper'

require File.join(File.dirname(__FILE__),'../..','mocha_helper')

module Ghaki module Logger module SpecHelper_Testing
describe SpecHelper do
  include SpecHelper

  before(:each) do
    remove_instance_variable(:@logger) if defined?(@logger)
  end

  describe '#make_safe_logger' do
    it 'returns null logger' do
      make_safe_logger.should be_an_instance_of(Null)
    end
  end

  describe '#setup_safe_logger' do
    it 'creates null logger' do
      setup_safe_logger
      defined?(@logger).should be_true
    end
    it 'caches null logger' do
      setup_safe_logger
      x = @logger
      setup_safe_logger
      x.should equal(@logger)
    end
  end

  describe '#clear_safe_logger' do
    it 'destroys null logger' do
      setup_safe_logger
      clear_safe_logger
      @logger.should be_nil
    end
  end

  describe '#reset_safe_logger' do
    it 'creates new logger' do
      setup_safe_logger
      x = @logger
      reset_safe_logger
      x.should_not equal(@logger)
    end
  end

end
end end end
