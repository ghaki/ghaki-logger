############################################################################
require 'ghaki/app/engine'
require 'ghaki/logger/app'

describe Ghaki::App::Engine do

  before(:all) do
    @eng_app = Ghaki::App::Engine.instance
    @log_app = Ghaki::Logger::App.instance
  end

  context 'singleton' do
    subject { @eng_app }
    it { should respond_to :logger  }
    it { should respond_to :logger= }
    it { should respond_to :logger_opts  }
    it { should respond_to :logger_opts= }
    it { should respond_to :logger_defs  }
    it { should respond_to :logger_defs= }
  end

  context 'singleton methods' do

    describe '#logger' do
      subject { @eng_app.logger }
      specify { should be_an_instance_of(Ghaki::Logger::Base) }
      specify { should equal(@log_app.logger) }
    end

    describe '#logger_opts' do
      subject { @eng_app.logger_opts }
      specify { should be_an_instance_of(::Hash) }
    end

    describe '#logger_defs' do
      subject { @eng_app.logger_defs }
      specify { should be_an_instance_of(::Hash) }
    end

  end

end
