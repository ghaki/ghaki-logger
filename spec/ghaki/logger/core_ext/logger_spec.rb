############################################################################
require 'ghaki/logger/core_ext'

############################################################################
module Ghaki module Logger module CoreExt module LoggerTesting
  describe ::Logger do

    describe 'monkey patched object' do
      subject { ::Logger.new($stdout) }
      it { should respond_to :filename }
      it { should respond_to :rotate }
      it { should respond_to :shift_age }
      it { should respond_to :shift_age= }
      it { should respond_to :shift_size }
      it { should respond_to :shift_size= }
      it { should respond_to :re_open }
      it { should respond_to :re_stds }
      it { should respond_to :re_stderr }
      it { should respond_to :re_stdout }
    end

  end
end end end end
############################################################################
