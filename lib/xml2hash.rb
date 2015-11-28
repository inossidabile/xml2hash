require 'xml2hash/typical_handler'
require 'xml2hash/version'

module Xml2Hash
  if defined?(Ox)
    class WithOx
      include TypicalHandler
      alias :text :characters
    end
  end

  if defined?(Nokogiri)
    class WithNokogiri < Nokogiri::XML::SAX::Document
      include TypicalHandler
    end
  end

  def self.parse(stream, parser=nil)
    stream = StringIO.new(stream) if stream.is_a?(String)

    if parser.nil?
      if defined?(WithOx)
        parser = :ox
      elsif defined?(WithNokogiri)
        parser = :nokogiri
      end
    end

    if parser == :ox && defined?(WithOx)
      handler = WithOx.new
      Ox.sax_parse(handler, stream)
      handler.pointer

    elsif parser == :nokogiri && defined?(WithNokogiri)
      handler = WithNokogiri.new
      Nokogiri::XML::SAX::Parser.new(handler).parse(stream)
      handler.pointer

    else
      raise 'No SAX XML parser available'

    end
  end
end
