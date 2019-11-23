#!/usr/bin/env ruby
require 'httparty'
require 'hexapdf'

response = HTTParty.get("https://rubydesign.fi/api/purchase.json")
items = {}
response.parsed_response["items"].each do |item|
  items[item["scode"]] = item
end
class ShowTextProcessor < HexaPDF::Content::Processor
  attr_reader :total
  def initialize(page , items)
    super()
    @canvas = page.canvas(type: :overlay)
    @items = items
    @total = 0
  end

  def show_text(str)
    boxes = decode_text_with_positioning(str)
    number = @items.delete( boxes.string )
    return unless number
    x, y = *boxes.lower_left
    @canvas.font('Courier', size: 8)
    @canvas.text( number["quantity"].to_s , at: [x - 23 , y + 3])
    @total += number["quantity"]
  end
  alias :show_text_with_positioning :show_text
end


def dump_extra(items)
  puts "ItemNo  Määrä Nimi"
  items.each do | code , item|
    puts "#{code}  #{item['quantity']} #{item['name']}"
  end
end

Dir["app/assets/Farfalla*"].each do |file|

  doc = HexaPDF::Document.open(file)
  out = file.split("/").last
  total = 0
  doc.pages.each_with_index do |page, index|
    processor = ShowTextProcessor.new(page, items)
    page.process_contents(processor)
    #puts "Sivu #{index + 1} #{file}      #{processor.total}"
    total += processor.total
  end
  if(total > 0)
    puts "writing #{out}  , #{total}"
    doc.write("#{Dir.home}/Desktop/#{out}")
  end
end
dump_extra(items) unless items.empty?
