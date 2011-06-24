require 'ghaki/logger/mixin'

module Ghaki module Logger module Mixin_Testing
describe Ghaki::Logger::Mixin do

  context 'object extended by' do
    class Quack
      include Ghaki::Logger::Mixin
    end
    subject { Quack.new }
    it { should respond_to :logger }
    it { should respond_to :logger= }
  end

end
end end end
