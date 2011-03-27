############################################################################
require 'spec_helper'
require 'ghaki/logger/base'

############################################################################
module Ghaki module Logger module BaseTesting
  describe Ghaki::Logger::Base do

    ########################################################################
    before(:each) do
      @core_log = flexmock()
      flexmock( :safe, ::Logger ) do |fm|
        fm.should_receive(:new).returns(@core_log)
      end
      @core_log.should_receive(:level=).once
      @core_log.should_receive(:datetime_format=).once
      @real_log = Ghaki::Logger::Base.new
    end

    ########################################################################
    context 'object' do
      subject { @real_log }
      context 'delegated features' do
        %w{
          level rotate
          shift_age shift_age= shift_size shift_size=
          re_open re_stds re_stderr re_stdout
        }.each do |name|
          it { should respond_to name.to_sym }
        end
      end
      context 'new features' do
        it { should respond_to :major }
        it { should respond_to :minor }
        it { should respond_to :level= }
      end
      context 'included features' do
        it { should respond_to :liner }
        it { should respond_to :fatal_dump }
        it { should respond_to :box }
        it { should respond_to :puts }
      end
    end

    ########################################################################
    context 'object methods' do

      #---------------------------------------------------------------------
      describe '#major' do
        subject { @real_log.major }
        specify { should be_an_instance_of(Ghaki::Logger::Wrapper::Major) }
      end

      #---------------------------------------------------------------------
      describe '#minor' do
        subject { @real_log.minor }
        specify { should be_an_instance_of(Ghaki::Logger::Wrapper::Minor) }
      end

      #---------------------------------------------------------------------
      describe '#level=' do
        it 'should call parent' do
          @core_log.should_receive(:level=).once
          @real_log.level = ::Logger::INFO
        end
        it 'should reject invalid values' do
          lambda do
            @real_log.level = 'quack'
          end.should raise_error( ArgumentError, /\bInvalid\slog\slevel\b/ )
        end
      end

    end

  end
end end end
############################################################################
