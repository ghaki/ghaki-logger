############################################################################
require 'ghaki/logger/core_ext'

############################################################################
module Ghaki module Logger module CoreExt module LogDeviceTesting
  describe ::Logger::LogDevice do

    context 'monkey patched objects' do
      subject { ::Logger::LogDevice.new($stdout) }
      it { should respond_to :shift_age  }
      it { should respond_to :shift_age= }
      it { should respond_to :shift_size  }
      it { should respond_to :shift_size= }
      it { should respond_to :rotate }
      it { should respond_to :re_open }
      it { should respond_to :filename  }
    end

  end
end end end end
############################################################################
