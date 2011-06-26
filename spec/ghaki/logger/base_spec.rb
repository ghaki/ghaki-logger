require 'ghaki/logger/base'

require File.join(File.dirname(__FILE__),'../..','mocha_helper')

module Ghaki module Logger module Base_Testing
describe Ghaki::Logger::Base do

  before(:each) do
    @dev = stub_everything('Logger::LogDevice')
    ::Logger::LogDevice.stubs( :new => @dev )
    @subj = Ghaki::Logger::Base.new
  end

  it { should be_kind_of(::Logger) }
  it { should be_kind_of(Ghaki::Logger::Liner) }

  it { should respond_to :major }
  it { should respond_to :minor }

  describe '#initialize' do
    it 'accepts option :level' do
      @subj = Ghaki::Logger::Base.new( :level => :fatal )
      @subj.level.should == ::Logger::FATAL
    end
    it 'defaults option :level' do
      @subj = Ghaki::Logger::Base.new
      @subj.level.should == Ghaki::Logger::DEF_LEVEL
    end
    it 'accepts option :datetime_format' do
      @subj = Ghaki::Logger::Base.new( :datetime_format => '%Y' )
      @subj.datetime_format.should == '%Y'
    end
    it 'defaults option :datetime_format' do
      @subj = Ghaki::Logger::Base.new
      @subj.datetime_format.should == Ghaki::Logger::DEF_DATETIME_FORMAT
    end
  end

  describe '#dup' do
    before(:each) do
      @dup = @subj.dup
    end
    subject { @dup }
    it 'returns logger' do
      should be_an_instance_of(Ghaki::Logger::Base)
    end
    it 'grabs copy of file handle' do
      @dup.logdev.should == @subj.logdev
    end
    %w{ datetime_format level filename shift_age shift_size box_char box_size }.each do |token|
      instance_eval <<-"END"
        it 'clones #{token}' do
          @dup.#{token}.should == @subj.#{token}
        end
      END
    end
  end

  describe '#major' do
    subject { @subj.major }
    specify { should be_an_instance_of(Ghaki::Logger::Wrapper::Major) }
  end

  describe '#minor' do
    subject { @subj.minor }
    specify { should be_an_instance_of(Ghaki::Logger::Wrapper::Minor) }
  end

  describe '#level=' do
    it 'translates accepted values' do
      SEVERITY_LOOKUP.each_pair do |key,val|
        subject.level = key
        subject.level.should == val
      end
    end
    it 'rejects invalid values' do
      lambda do
        @subj.level = 'quack'
      end.should raise_error( ArgumentError, /\bInvalid\slog\slevel\b/ )
    end
  end

end
end end end
############################################################################
