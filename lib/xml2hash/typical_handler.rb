module Xml2Hash
  module TypicalHandler
    def initialize
      @pointer = {}
      @stack   = []
    end

    def pointer
      @pointer
    end

    def start_element(name, attrs=[])
      @stack.push(@pointer)

      @name    = name.to_s
      @pointer = {}

      if @stack.last.include?(@name)
        if @stack.last[@name].is_a?(Array)
          @stack.last[@name] << @pointer
        else
          @stack.last[@name] = [@stack.last[@name], @pointer]
        end
      else
        @stack.last[@name] = @pointer
      end
    end

    def end_element(name)
      @pointer = @stack.pop

      # Ox doesn't send text event for blank tag so we have to
      # clean up that when tag closes
      if @pointer[@name] == {}
        @pointer[@name] = nil
      end

      # Ox doesn't send text event for blank tag so we have to
      # clean up that when tag closes
      if @pointer[@name].is_a?(Array) && @pointer[@name].last == {}
        @pointer[@name][@pointer[@name].length - 1] = nil
      end
    end

    def characters(value)
      if @stack.last[@name].is_a?(Array)
        @stack.last[@name].pop
        @stack.last[@name] << value
      else
        @stack.last[@name] = value
      end
    end
  end
end