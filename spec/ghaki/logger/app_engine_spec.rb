############################################################################
require 'ghaki/logger/app'

############################################################################
module Ghaki module App module EngineTesting
  begin
    require 'ghaki/app/engine'

    describe Ghaki::App::Engine do
      context 'singleton' do
        subject { Ghaki::App::Engine.instance }
        it { should respond_to :logger  }
        it { should respond_to :logger= }
        it { should respond_to :logger_opts  }
        it { should respond_to :logger_opts= }
      end
      context 'singleton methods' do
        describe '#logger' do
          subject { Ghaki::App::Engine.instance.logger }
          specify { should be_an_instance_of(Ghaki::Logger::Base) }
          specify { should equal(Ghaki::Logger::App.instance.logger) }
        end
        describe '#logger_opts' do
          subject { Ghaki::App::Engine.instance.logger_opts }
          specify { should be_an_instance_of(::Hash) }
        end
      end
    end

  rescue LoadError
    describe 'Ghaki::App::Engine' do
      pending 'external library not available: <ghaki/app/engine>'
    end
  end

end end end
############################################################################
