module Godwit
  # This class is used to buffer output.  It's used to help out with view
  # switching in the console.
  #
  class Buffer

    class << self

      # Returns the buffer.
      #
      def buffer
        @buffer ||= ""
        @buffer
      end

      # Sets the buffer
      #
      def buffer=(string)
        @buffer ||= ""
        @buffer = string
      end

      # Outputs text with Kernel#print and stores it in the buffer.
      #
      def print(string)
        self.buffer += string
        Kernel.print string
      end

      # Outputs text with Kernel#puts and stores it in the buffer.
      #
      def puts(string)
        self.buffer += (string + "\n")
        Kernel.puts string
      end

      # Clears the buffer.
      #
      def clear
        self.buffer = ""
      end

    end

  end
end