############################################################################
module Ghaki module Logger
  module Deprecated

    ########################################################################
    %w{ major minor }.each do |level|

      #---------------------------------------------------------------------
      # WITH BLOCK
      #---------------------------------------------------------------------
      %w{ wrap wrap_if }.each do |name|
        fun_old = level + '_' + name
        fun_new = level + '.' + name
        module_eval <<-"END"
          def #{fun_old} msg, *args, &block
            warn "[DEPRECATION] '#{fun_old}' is deprecated.  Please use '#{fun_new}' instead."
            #{fun_new}( msg, *args, &block )
          end
        END
      end

      #---------------------------------------------------------------------
      # WITHOUT BLOCK
      #---------------------------------------------------------------------
      %w{ began ended step }.each do |name|
        fun_old = level + '_' + name
        fun_new = level + '.' + name
        module_eval <<-"END"
          def #{fun_old} msg, *args
            warn "[DEPRECATION] '#{fun_old}' is deprecated.  Please use '#{fun_new}' instead."
            #{fun_new}( msg, *args )
          end
        END
      end

    end # major/minor

    ########################################################################
    { :rebox     => :box,
      :reindent  => :puts,
      :puts_list => :puts,
    }.each do |fun_old,fun_new|
      define_method fun_old do |*args|
        warn "[DEPRECATION] '#{fun_old}' is deprecated.  Please use '#{fun_new}' instead."
        self.send( fun_new, *args )
      end
    end

  end # helper
end end # package
############################################################################
