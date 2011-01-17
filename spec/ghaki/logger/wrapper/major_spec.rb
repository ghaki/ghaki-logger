############################################################################
require File.join( File.dirname(__FILE__), '..', 'common_helper' )

############################################################################
module Ghaki module Logger module Wrapper module MajorTesting
  describe Ghaki::Logger::Wrapper::Major do

    include Ghaki::Logger::CommonHelper
    before(:each) do reset_log end
    after(:each)  do delete_log end

    ##################################################################
    MAJOR_LINER  = '# ' + (Ghaki::Logger::MAJOR_BOX_CHAR * Ghaki::Logger::DEF_BOX_SIZE)

    subject { @log.major }

    ##################################################################
    context 'object' do
      it { should respond_to :began }
      it { should respond_to :ended }
      it { should respond_to :step }
      it { should respond_to :wrap }
      it { should respond_to :wrap! }
      it { should respond_to :wrap_if }
      it { should respond_to :wrap_if! }
    end

    ##################################################################
    describe '#began' do
      it 'should have proper default output' do
        subject.began 'testing'
        slurp_log
        @lines.length.should == 3
        @lines[0].should == MAJOR_LINER
        @lines[1].should =~ %r{\:\sBEGAN\stesting}o
        @lines[2].should == MAJOR_LINER
      end
      it 'should allow box char override' do
        @log.major.began 'testing', '/', 4
        slurp_log
        @lines.length.should == 3
        @lines[0].should == '# ////'
        @lines[1].should =~ %r{\:\sBEGAN\stesting}o
        @lines[2].should == '# ////'
      end
    end

    ##################################################################
    describe '#ended' do
      it 'should have proper default output' do
        subject.ended 'testing'
        slurp_log
        @lines.length.should == 3
        @lines[0].should == MAJOR_LINER
        @lines[1].should =~ %r{\:\sENDED\stesting}o
        @lines[2].should == MAJOR_LINER
      end
    end

    ##################################################################
    describe '#step' do
      it 'should have proper default output' do
        subject.step 'testing'
        slurp_log
        @lines.length.should == 1
        @lines[0].should =~ %r{\:\sSTEP\stesting}o
      end
    end

    ##################################################################
    describe '#wrap' do
      it 'should have proper default output' do
        subject.wrap 'testing' do
          @log.puts 'quack'
        end
        slurp_log
        @lines.length.should == 7
        @lines[0].should == MAJOR_LINER
        @lines[1].should =~ %r{\:\sBEGAN\stesting}o
        @lines[2].should == MAJOR_LINER
        @lines[3].should == '# quack'
        @lines[4].should == MAJOR_LINER
        @lines[5].should =~ %r{\:\sENDED\stesting}o
        @lines[6].should == MAJOR_LINER
      end
      it 'should pass through yielded return value' do
        out = subject.wrap 'quack' do
          out = 2 + 3
        end
        out.should == 5
      end
      it 'should interrupt flow for exceptions' do
        lambda do
          subject.wrap 'quack' do
            raise ArgumentError, 'Moo'
          end
        end.should raise_error(ArgumentError)
        slurp_log
        @lines.length.should == 3
        @lines[0].should == MAJOR_LINER
        @lines[1].should =~ %r{\:\sBEGAN\s}o
        @lines[2].should == MAJOR_LINER
      end
    end

    ##################################################################
    describe '#wrap!' do
      it 'should have proper default output' do
        subject.wrap! 'testing' do
          @log.puts 'quack'
        end
        slurp_log
        @lines.length.should == 7
        @lines[0].should == MAJOR_LINER
        @lines[1].should =~ %r{\:\sBEGAN\stesting}o
        @lines[2].should == MAJOR_LINER
        @lines[3].should == '# quack'
        @lines[4].should == MAJOR_LINER
        @lines[5].should =~ %r{\:\sENDED\stesting}o
        @lines[6].should == MAJOR_LINER
      end
      it 'should pass through yielded return value' do
        out = subject.wrap! 'quack' do
          out = 2 + 3
        end
        out.should == 5
      end
      it 'should not interrupt flow for exceptions' do
        lambda do
          subject.wrap! 'quack' do
            raise ArgumentError
          end
        end.should raise_error(ArgumentError)
        slurp_log
        @lines.length.should == 6
        @lines[0].should == MAJOR_LINER
        @lines[1].should =~ %r{\:\sBEGAN\s}o
        @lines[2].should == MAJOR_LINER
        @lines[3].should == MAJOR_LINER
        @lines[4].should =~ %r{\:\sENDED\s}o
        @lines[5].should == MAJOR_LINER
      end
    end

    ##################################################################
    describe '#wrap_if' do
      it 'should skip' do
        subject.wrap_if false, 'testing' do
          @log.puts 'quack'
        end
        slurp_log
        @lines.length.should == 1
        @lines[0].should =~ %r{\:\sSTEP\stesting\s\-\sskipping}o
      end
      it 'should process' do
        subject.wrap_if true, 'testing' do
          @log.puts 'quack'
        end
        slurp_log
        @lines.length.should == 7
        @lines[0].should == MAJOR_LINER
        @lines[1].should =~ %r{\:\sBEGAN\stesting}o
        @lines[2].should == MAJOR_LINER
        @lines[3].should == '# quack'
        @lines[4].should == MAJOR_LINER
        @lines[5].should =~ %r{\:\sENDED\stesting}o
        @lines[6].should == MAJOR_LINER
      end
      it 'should interrupt flow for exceptions' do
        lambda do
          subject.wrap 'quack' do
            raise ArgumentError, 'Moo'
          end
        end.should raise_error(ArgumentError)
        slurp_log
        @lines.length.should == 3
        @lines[0].should == MAJOR_LINER
        @lines[1].should =~ %r{\:\sBEGAN\s}o
        @lines[2].should == MAJOR_LINER
      end
    end

    ##################################################################
    describe '#wrap_if!' do
      it 'should skip' do
        subject.wrap_if! false, 'testing' do
          @log.puts 'quack'
        end
        slurp_log
        @lines.length.should == 1
        @lines[0].should =~ %r{\:\sSTEP\stesting\s\-\sskipping}o
      end
      it 'should process' do
        subject.wrap_if! true, 'testing' do
          @log.puts 'quack'
        end
        slurp_log
        @lines.length.should == 7
        @lines[0].should == MAJOR_LINER
        @lines[1].should =~ %r{\:\sBEGAN\stesting}o
        @lines[2].should == MAJOR_LINER
        @lines[3].should == '# quack'
        @lines[4].should == MAJOR_LINER
        @lines[5].should =~ %r{\:\sENDED\stesting}o
        @lines[6].should == MAJOR_LINER
      end
      it 'should not interrupt flow for exceptions' do
        lambda do
          subject.wrap! 'quack' do
            raise ArgumentError
          end
        end.should raise_error(ArgumentError)
        slurp_log
        @lines.length.should == 6
        @lines[0].should == MAJOR_LINER
        @lines[1].should =~ %r{\:\sBEGAN\s}o
        @lines[2].should == MAJOR_LINER
        @lines[3].should == MAJOR_LINER
        @lines[4].should =~ %r{\:\sENDED\s}o
        @lines[5].should == MAJOR_LINER
      end
    end

  end
end end end end
############################################################################
