require 'ghaki/app/mixable'
require 'ghaki/logger/app'

module Ghaki  #:nodoc:
module Logger #:nodoc:

  # Mixin used to add <b>logger</b> to your classes.
  #
  # ==== Usage
  #
  # class MyClass
  #   include Ghaki::Logger::Mixin
  #   def do_something
  #     logger.step 'did something'
  #   end
  # end
  #
  # myobj = MyClass.new
  # myobj.do_something

  module Mixin
    include Ghaki::App::Mixable
    app_mixin_accessor App, :logger
  end
  
end end
