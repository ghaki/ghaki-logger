require 'ghaki/logger/core_ext'
require 'ghaki/logger/null'

module Ghaki module Logger module Null_Testing
describe Null do

  describe '#initialize' do
    it 'ignores :file_handle' do
      bad = stub_everything()
      Null.new( :file_handle => bad ).with_file do |file|
        file.should_not be(bad)
      end
    end
    it 'ignores :log_device' do
      bad = stub_everything()
      Null.new( :log_device => bad ).logdev.should_not be(bad)
    end
    it 'intercepts :file_name' do
      fname = 'file'
      Null.new( :file_name => fname ).filename.should === fname
    end
  end

  before(:each) do
    @subj = Ghaki::Logger::Null.new({
      :file_name => 'file',
    })
    @log_dev = @subj.logdev
  end

  subject { @subj }

  it { should be_kind_of(Ghaki::Logger::Base) }

  describe '#with_file' do
    it 'creates StringIO instead of LogDevice' do
      subject.with_file do |file|
        file.should be_instance_of(StringIO)
      end
    end
  end

  it { should respond_to :allow_redirection! }
  it { should respond_to :allow_redirection? }

  it { should respond_to :file_name }
  describe '#filename' do
    it 'returns specified filename' do
      subject.filename.should == 'file'
    end
  end

  describe '#re_stds' do
    context 'when allowing redirection' do
      it 'passes calls to log device' do
        subject.allow_redirection! true
        @log_dev.expects(:re_stds).once
        subject.re_stds
      end
    end
    context 'when disallowing redirection' do
      it 'blocks calls to log device' do
        subject.allow_redirection! false
        @log_dev.expects(:re_stds).never
        subject.re_stds
      end
    end
  end

  describe '#re_stdout' do
    context 'when allowing redirection' do
      it 'passes calls to log device' do
        subject.allow_redirection! true
        @log_dev.expects(:re_stdout).once
        subject.re_stdout
      end
    end
    context 'when disallowing redirection' do
      it 'blocks calls to log device' do
        subject.allow_redirection! false
        @log_dev.expects(:re_stdout).never
        subject.re_stdout
      end
    end
  end

  describe '#re_stderr' do
    context 'when allowing redirection' do
      it 'passes calls to log device' do
        subject.allow_redirection! true
        @log_dev.expects(:re_stderr).once
        subject.re_stderr
      end
    end
    context 'when disallowing redirection' do
      it 'blocks calls to log device' do
        subject.allow_redirection! false
        @log_dev.expects(:re_stderr).never
        subject.re_stderr
      end
    end
  end

end
end end end
