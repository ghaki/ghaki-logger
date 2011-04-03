module Ghaki  #:nodoc:
module Logger #:nodoc:

  # Logging helpers.

  module Liner

    attr_accessor :box_char, # Character used to make line separators in the logs.
      :box_size # Line length used for separators in the logs.

    # Writes a log comment line.
    # [+box_char+] Character used to make line separators in the logs.
    # [+box_size+] Line length used for separators in the logs.

    def liner box_char=@box_char, box_size=@box_size
      self.puts( box_char * box_size ) if self.debug?
    end

    # Dump exception to logger. Includes backtrace if debugging is set.

    def fatal_dump why
      self.fatal why.class.to_s + ' ' + why.to_s
      self.liner '!'
      self.puts why.backtrace if self.debug?
      self.liner '!'
    end

    # Creates a log comment box around an array of strings.
    # [+box_char+] Character used to make line separators in the logs.
    # [+box_size+] Line length used for separators in the logs.

    def box msgs, box_char=@box_char, box_size=@box_size
      self.liner box_char, box_size
      [msgs].flatten.each do |text|
        text.each_line do |line|
          self.<< '# ' + box_char + ' ' + line + "\n"
        end
      end
      self.liner box_char, box_size
    end

    # Write array of strings to logger, putting log comment characters in front of the lines.

    def puts msgs
      [msgs].flatten.each do |text|
        text.each_line do |line|
          self.<< '# ' + line + "\n"
        end
      end
    end

    protected

    def setup_liner opts #:nodoc:
      @box_size = opts[:box_size] || DEF_BOX_SIZE
      @box_char = opts[:box_char] || DEF_BOX_CHAR
    end

  end
end end
