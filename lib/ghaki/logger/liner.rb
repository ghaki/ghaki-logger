############################################################################
module Ghaki module Logger
  module Liner

    ########################################################################
    attr_accessor :box_char, :box_size

    #-----------------------------------------------------------------------
    def liner box_char=@box_char, box_size=@box_size
      self.puts( box_char * box_size ) if self.debug?
    end

    #-----------------------------------------------------------------------
    def fatal_dump why
      self.fatal why.class.to_s + ' ' + why.to_s
      self.liner '!'
      self.puts why.backtrace if self.debug?
      self.liner '!'
    end

    #-----------------------------------------------------------------------
    def box msgs, box_char=@box_char, box_size=@box_size
      self.liner box_char, box_size
      [msgs].flatten.each do |text|
        text.each_line do |line|
          self.<< '# ' + box_char + ' ' + line + "\n"
        end
      end
      self.liner box_char, box_size
    end

    #-----------------------------------------------------------------------
    def puts msgs
      [msgs].flatten.each do |text|
        text.each_line do |line|
          self.<< '# ' + line + "\n"
        end
      end
    end

    ########################################################################
    protected
    ########################################################################

    #-----------------------------------------------------------------------
    def setup_liner opts
      @box_size = opts[:box_size] || DEF_BOX_SIZE
      @box_char = opts[:box_char] || DEF_BOX_CHAR
    end

  end # helper
end end # package
############################################################################
