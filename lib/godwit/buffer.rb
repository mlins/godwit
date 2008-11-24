module Godwit
  class Buffer

    class << self

      def buffer
        @buffer ||= ""
        @buffer
      end

      def buffer=(string)
        @buffer ||= ""
        @buffer = string
      end

      def print(string)
        self.buffer += string
        Kernel.print string
      end

      def puts(string)
        self.buffer += (string + "\n")
        Kernel.puts string
      end

      def clear
        self.buffer = ""
      end

    end

  end
end