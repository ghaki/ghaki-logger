require 'ghaki/logger/app'

module Ghaki module Logger module App_Testing
describe Ghaki::Logger::App do

  context 'singleton' do
    subject { Ghaki::Logger::App.instance }
    it { should respond_to :logger  }
    it { should respond_to :logger= }
    it { should respond_to :logger_opts  }
    it { should respond_to :logger_opts= }
  end

  context 'singleton methods' do

    describe '#logger' do
      subject { Ghaki::Logger::App.instance.logger }
      specify { should be_an_instance_of(Ghaki::Logger::Base) }
    end

    describe '#logger_opts' do
      subject { Ghaki::Logger::App.instance.logger_opts }
      specify { should be_an_instance_of(::Hash) }
    end

    context 'default settings' do
      describe '#level' do
        subject { Ghaki::Logger::App.instance.logger.level }
        specify { should == ::Logger::INFO }
      end
      describe '#box_char' do
        subject { Ghaki::Logger::App.instance.logger.box_char }
        specify { should == Ghaki::Logger::DEF_BOX_CHAR }
      end
      describe '#box_size' do
        subject { Ghaki::Logger::App.instance.logger.box_size }
        specify { should == Ghaki::Logger::DEF_BOX_SIZE }
      end
    end
  end

end
end end end
