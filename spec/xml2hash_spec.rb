require 'spec_helper'

describe Xml2Hash do
  it 'has a version number' do
    expect(Xml2Hash::VERSION).not_to be nil
  end

  %i(ox nokogiri).each do |parser|
    context "with #{parser}" do
      describe ".parse" do
        it "parses xml into hash" do
          xml = '<a><b><c>Hello</c><d>World</d></b></a>'
          json = { "a" => { "b" => { "c" => "Hello", "d" => "World" } } }
          expect(Xml2Hash.parse(xml, parser)).to eq(json)

          xml = '<a><b><x>Io</x><c><d>Hello</d><e>World</e></c></b></a>'
          json = { "a" => { "b" => { "x" => "Io", "c" => { "d" => "Hello", "e" => "World" } } } }
          expect(Xml2Hash.parse(xml, parser)).to eq(json)
        end

        it "handles empty elements" do
          xml = '<a></a>'
          if parser == :ox
            expect(Xml2Hash.parse(xml, parser)).to(
              eq( {"a" => ""})
            )
          elsif parser == :nokogiri
            expect(Xml2Hash.parse(xml, parser)).to(
              eq({"a" => nil})
            )
          end
        end

        it "handles multiple elements" do
          xml = '<a><x><b>First</b><b>Second</b></x></a>'
          expect(Xml2Hash.parse(xml, parser)).to(
            eq({ "a" => { "x" => { "b" => [ "First", "Second" ] } } })
          )

          xml = '<a><b><x>First</x></b><b><x>Second</x></b></a>'
          expect(Xml2Hash.parse(xml, parser)).to(
            eq({ "a" => { "b" => [ { "x" => "First" }, { "x" => "Second" } ] } })
          )

          xml = '<a><b><x>First</x></b><b><x>Second</x></b><b><x>Third</x></b></a>'
          expect(Xml2Hash.parse(xml, parser)).to(
            eq({ "a" => { "b" => [ { "x" => "First" }, { "x" => "Second" }, { "x" => "Third" }] } })
          )
        end

        it "ignores node attributes" do
          xml = '<r><a url="www.google.it"></a></r>'
          if parser == :ox
            expect(Xml2Hash.parse(xml, parser)).to(
              eq({"r" => {"a" => ""}})
            )
          elsif parser == :nokogiri
            expect(Xml2Hash.parse(xml, parser)).to(
              eq({"r" => {"a" => nil}})
            )
          end
        end
      end
    end
  end
end
