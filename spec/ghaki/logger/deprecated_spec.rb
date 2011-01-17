############################################################################
require 'ghaki/logger/base'

############################################################################
module Ghaki module Logger module DeprecatedTesting
  describe Ghaki::Logger::Base do

    RX_DEP = %r{\[DEPRECATION\]}o

    ########################################################################
    before(:each) do
      @core_log = flexmock()
      flexmock( :safe, ::Logger ) do |fm|
        fm.should_receive(:new).and_return(@core_log)
      end
      @core_log.should_receive(:level=).once
      @core_log.should_receive(:datetime_format=).once
      @real_log = Ghaki::Logger::Base.new
    end
    subject { @real_log }

    ########################################################################
    context 'object' do
      context 'deprecated methods' do
        %w{ major minor }.each do |level|
          %w{ began ended step wrap wrap_if }.each do |func|
            it { should respond_to :"#{level}_#{func}" }
          end
        end
        it { should respond_to :rebox }
        it { should respond_to :reindent }
        it { should respond_to :puts_list }
      end
    end

    ########################################################################
    context 'object methods' do

      %w{ major minor }.each do |level| %w{ began ended step }.each do |func|
        fun_old = "#{level}_#{func}"

        #===================================================================
        describe "##{fun_old}" do

          # override major to detect redirected call
          before(:each) do
            # override warn to check that's it's being called (also silences)
            flexmock( :safe, @real_log ) do |fm|
              fm.should_receive(:warn).with(RX_DEP).once
            end
            flexmock( :safe, @real_log.send(level.to_sym) ) do |fm|
              fm.should_receive(func.to_sym).with('msg').once
            end
          end
          it 'should call wrapper object' do
            @real_log.send( fun_old.to_sym, 'msg' )
          end
          it 'should warn about deprecation' do
            @real_log.send( fun_old.to_sym, 'msg' )
          end

        end
      end end

      ######################################################################
      { :rebox => :box,
        :reindent => :puts,
        :puts_list => :puts,
      }.each do |fun_old,fun_new|
        describe "##{fun_old}" do
          before(:each) do 
            flexmock( :safe, @real_log ) do |fm|
              fm.should_receive(:warn).with(RX_DEP).once
            end
            flexmock( :safe, @real_log ) do |fm|
              fm.should_receive(fun_new).with('msg').once
            end
          end
          it 'should call wrapper object' do
            @real_log.send( fun_old, 'msg' )
          end
          it 'should warn about deprecation' do
            @real_log.send( fun_old, 'msg' )
          end
        end
      end

    end

  end
end end end
############################################################################
