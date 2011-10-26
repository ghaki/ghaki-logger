require File.join( File.dirname(__FILE__), 'common_helper' )

module Ghaki module Logger module Liner_Testing
describe Ghaki::Logger::Base do
  include Ghaki::Logger::CommonHelper

  before(:each) do reset_log end
  after(:each)  do delete_log end
  subject { @log }

  DEF_LINER = '# ' + (Ghaki::Logger::DEF_BOX_CHAR * Ghaki::Logger::DEF_BOX_SIZE)

  it { should respond_to :fatal_dump }

  describe '#liner' do
    it 'uses defaults' do
      @log.liner
      slurp_log
      @lines.length.should == 1
      @lines[0].should == DEF_LINER
    end
    it 'accepts customization' do
      @log.liner '-', 23
      slurp_log
      @lines.length.should == 1
      @lines[0].should == '# ' + ('-' * 23)
    end
  end

  describe '#box' do
    it 'uses defaults' do
      @log.box 'quack'
      slurp_log
      @lines.length.should == 3
      @lines[0].should == DEF_LINER
      @lines[1].should == '# = quack'
      @lines[2].should == DEF_LINER
    end
    it 'accepts customization' do
      @log.box 'quack', '*', 23
      slurp_log
      my_liner = '# ' + ('*' * 23)
      @lines.length.should == 3
      @lines[0].should == my_liner
      @lines[1].should == '# * quack'
      @lines[2].should == my_liner
    end
  end

  describe '#puts' do
    it 'outputs simple string' do
      @log.puts 'quack'
      slurp_log
      @lines.length.should == 1
      @lines[0].should == '# quack'
    end
    it 'splits and chomps multilines' do
      @log.puts "foo\nbar\n"
      slurp_log
      @lines.length.should == 2
      @lines[0].should == '# foo'
      @lines[1].should == '# bar'
    end
  end

end
end end end
