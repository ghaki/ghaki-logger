############################################################################
require File.join( File.dirname(__FILE__), 'common_helper' )

############################################################################
module Ghaki module Logger module LinerTesting
  describe Ghaki::Logger::Base do

    ########################################################################
    include Ghaki::Logger::CommonHelper
    before(:each) do reset_log end
    after(:each)  do delete_log end

    DEF_LINER = '# ' + (Ghaki::Logger::DEF_BOX_CHAR * Ghaki::Logger::DEF_BOX_SIZE)

    ########################################################################
    context 'object' do
      subject { @log }
      it { should respond_to :puts }
      it { should respond_to :liner }
      it { should respond_to :box }
      it { should respond_to :fatal_dump }
    end

    ########################################################################
    context 'object methods' do

      ######################################################################
      describe '#liner' do
        #-------------------------------------------------------------------
        it 'should out using defaults' do
          @log.liner
          slurp_log
          @lines.length.should == 1
          @lines[0].should == DEF_LINER
        end
        #-------------------------------------------------------------------
        it 'should allow customization' do
          @log.liner '-', 23
          slurp_log
          @lines.length.should == 1
          @lines[0].should == '# ' + ('-' * 23)
        end
      end

      ######################################################################
      describe '#box' do
        #-------------------------------------------------------------------
        it 'should output using defaults' do
          @log.box 'quack'
          slurp_log
          @lines.length.should == 3
          @lines[0].should == DEF_LINER
          @lines[1].should == '# = quack'
          @lines[2].should == DEF_LINER
        end
        #-------------------------------------------------------------------
        it 'should allow customization' do
          @log.box 'quack', '*', 23
          slurp_log
          my_liner = '# ' + ('*' * 23)
          @lines.length.should == 3
          @lines[0].should == my_liner
          @lines[1].should == '# * quack'
          @lines[2].should == my_liner
        end
      end

      ######################################################################
      describe '#puts' do
        #-------------------------------------------------------------------
        it 'should output' do
          @log.puts 'quack'
          slurp_log
          @lines.length.should == 1
          @lines[0].should == '# quack'
        end
      end

    end

  end
end end end
############################################################################
