############################################################################
require 'mocha_helper'
require 'ghaki/logger/base'

############################################################################
module Ghaki module Logger module BaseTesting
describe Ghaki::Logger::Base do

  before(:each) do
    @core_dev = stub_everything('Logger::LogDevice')
    ::Logger::LogDevice.stubs( :new => @core_dev )
    @core_log = ::Logger.new(nil)
    @core_log.logdev = @core_dev
    ::Logger.stubs( :new => @core_log )
    @real_log = Ghaki::Logger::Base.new
  end

  context 'object' do
    subject { @real_log }
    context 'delegated features' do
      %w{
        level rotate
        shift_age shift_age= shift_size shift_size=
        re_open re_stds re_stderr re_stdout
        filename
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

  context 'object methods' do

    describe '#initialize' do
      it 'accepts option :level' do
        Ghaki::Logger::Base.new( :level => :fatal ).level.should == ::Logger::FATAL
      end
      it 'defaults option :level' do
        Ghaki::Logger::Base.new.level.should == Ghaki::Logger::DEF_LEVEL
      end
      it 'accepts option :datetime_format' do
        Ghaki::Logger::Base.new( :datetime_format => '%Y' ).datetime_format.should == '%Y'
      end
      it 'defaults option :datetime_format' do
        Ghaki::Logger::Base.new.datetime_format.should == Ghaki::Logger::DEF_DATETIME_FORMAT
      end
    end

    describe '#dup' do
      before(:each) do
        @subj = @real_log.dup
      end
      subject { @subj }
      it 'returns logger' do
        should be_an_instance_of(Ghaki::Logger::Base)
      end
      it 'grabs copy of file handle' do
        subject.logdev.should == @real_log.logdev
      end
      %w{ filename shift_age shift_size box_char box_size }.each do |token|
        instance_eval <<-"END"
          it 'clones #{token}' do
            subject.#{token}.should == @real_log.#{token}
          end
        END
      end
    end

    describe '#major' do
      subject { @real_log.major }
      specify { should be_an_instance_of(Ghaki::Logger::Wrapper::Major) }
    end

    describe '#minor' do
      subject { @real_log.minor }
      specify { should be_an_instance_of(Ghaki::Logger::Wrapper::Minor) }
    end

    describe '#level=' do
      it 'should call parent' do
        @core_log.expects(:level=).with(::Logger::INFO).once
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
