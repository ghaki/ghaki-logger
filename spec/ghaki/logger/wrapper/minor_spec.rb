############################################################################
require File.join( File.dirname(__FILE__), '..', 'common_helper' )

############################################################################
module Ghaki module Logger module Wrapper module MinorTesting
  describe Ghaki::Logger::Wrapper::Minor do

    include Ghaki::Logger::CommonHelper
    before(:each) do reset_log end
    after(:each)  do delete_log end

    subject { @log.minor }

    ########################################################################
    context 'object' do
      it { should respond_to :began }
      it { should respond_to :ended }
      it { should respond_to :step }
      it { should respond_to :wrap }
      it { should respond_to :wrap! }
      it { should respond_to :wrap_if }
      it { should respond_to :wrap_if! }
    end

    ########################################################################
    describe '#began' do
      it 'should have proper output' do
        subject.began 'testing'
        slurp_log
        @lines.length.should == 1
        @lines[0].should =~ %r{\:\sbegan\stesting}o
      end
    end

    ########################################################################
    describe "#ended" do
      it 'should have proper output' do
        subject.ended 'testing'
        slurp_log
        @lines.length.should == 1
        @lines[0].should =~ %r{\:\sended\stesting}o
      end
    end

    ########################################################################
    describe "#step" do
      it 'should have proper output' do
        subject.step 'testing'
        slurp_log
        @lines.length.should == 1
        @lines[0].should =~ %r{\:\sstep\stesting}o
      end
    end

    ########################################################################
    describe '#wrap' do

      #---------------------------------------------------------------------
      it "should wrap" do
        subject.wrap 'testing' do
          @log.puts 'quack'
        end
        slurp_log
        @lines.length.should == 3
        @lines[0].should =~ %r{\:\sbegan\stesting}o
        @lines[1].should == '# quack'
        @lines[2].should =~ %r{\:\sended\stesting}o
      end

      #---------------------------------------------------------------------
      it 'should pass through yielded return value' do
        out = subject.wrap 'quack' do
          out = 6 + 7
        end
        out.should == 13
      end

      #---------------------------------------------------------------------
      it 'should interrupt flow for exceptions' do
        lambda do
          subject.wrap 'testing' do
            raise 'test error'
          end
        end.should raise_error('test error')
        slurp_log
        @lines.length.should == 1
        @lines[0].should =~ %r{\:\sbegan\stesting}o
      end

    end

    ########################################################################
    describe '#wrap!' do

      #---------------------------------------------------------------------
      it "should wrap" do
        subject.wrap! 'testing' do
          @log.puts 'quack'
        end
        slurp_log
        @lines.length.should == 3
        @lines[0].should =~ %r{\:\sbegan\stesting}o
        @lines[1].should == '# quack'
        @lines[2].should =~ %r{\:\sended\stesting}o
      end

      #---------------------------------------------------------------------
      it 'should pass through yielded return value' do
        out = subject.wrap! 'quack' do
          out = 6 + 7
        end
        out.should == 13
      end

      #---------------------------------------------------------------------
      it 'should not interrupt flow for exceptions' do
        lambda do
          subject.wrap! 'testing' do
            raise 'test error'
          end
        end.should raise_error('test error')
        slurp_log
        @lines.length.should == 2
        @lines[0].should =~ %r{\:\sbegan\stesting}o
        @lines[1].should =~ %r{\:\sended\stesting}o
      end

    end

    ########################################################################
    describe '#wrap_if' do

      #---------------------------------------------------------------------
      it 'should skip' do
        subject.wrap_if false, 'testing' do
          @log.puts 'quack'
        end
        slurp_log
        @lines.length.should == 1
        @lines[0].should =~ %r{\:\sstep\stesting\s\-\sskipping}o
      end

      #---------------------------------------------------------------------
      it 'should process' do
        subject.wrap_if true, 'testing' do
          @log.puts 'quack'
        end
        slurp_log
        @lines.length.should == 3
        @lines[0].should =~ %r{\:\sbegan\stesting}o
        @lines[1].should == '# quack'
        @lines[2].should =~ %r{\:\sended\stesting}o
      end

      #---------------------------------------------------------------------
      it 'should interrupt flow for exceptions' do
        lambda do
          subject.wrap 'testing' do
            raise 'test error'
          end
        end.should raise_error('test error')
        slurp_log
        @lines.length.should == 1
        @lines[0].should =~ %r{\:\sbegan\stesting}o
      end
    end

    ########################################################################
    describe '#wrap_if!' do
      #---------------------------------------------------------------------
      it 'should skip' do
        subject.wrap_if! false, 'testing' do
          @log.puts 'quack'
        end
        slurp_log
        @lines.length.should == 1
        @lines[0].should =~ %r{\:\sstep\stesting\s\-\sskipping}o
      end
      #---------------------------------------------------------------------
      it 'should process' do
        subject.wrap_if! true, 'testing' do
          @log.puts 'quack'
        end
        slurp_log
        @lines.length.should == 3
        @lines[0].should =~ %r{\:\sbegan\stesting}o
        @lines[1].should == '# quack'
        @lines[2].should =~ %r{\:\sended\stesting}o
      end
      #---------------------------------------------------------------------
      it 'should not interrupt flow for exceptions' do
        lambda do
          subject.wrap! 'testing' do
            raise 'test error'
          end
        end.should raise_error('test error')
        slurp_log
        @lines.length.should == 2
        @lines[0].should =~ %r{\:\sbegan\stesting}o
        @lines[1].should =~ %r{\:\sended\stesting}o
      end
    end

  end
end end end end
############################################################################
