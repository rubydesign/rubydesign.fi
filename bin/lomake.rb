#!/usr/bin/env ruby
require 'net/http'
require 'json'
require 'hexapdf'

response = Net::HTTP.get(URI('https://rubydesign.fi/api/purchase'))
items = JSON.parse(response)["items"]

class ShowTextProcessor < HexaPDF::Content::Processor
  attr_reader :total
  def initialize(page)
    super()
    @canvas = page.canvas(type: :overlay)
    @items = items
    @total = 0
  end

  def show_text(str)
    boxes = decode_text_with_positioning(str)
    return if boxes.string.empty?
    puts "String #{boxes.string}"
    if( boxes.string == "eppoapb75")
      x, y = *boxes.lower_left
      @canvas.font('Courier', size: 8)
      @canvas.text( "10" , at: [x - 20 , y])
    end

  end
  alias :show_text_with_positioning :show_text
end



doc = HexaPDF::Document.open(ARGV.shift)

total = 0
doc.pages.each_with_index do |page, index|
  puts "Sivu #{index + 1} #{file}"
  processor = ShowTextProcessor.new(page, items)
  page.process_contents(processor)
  total += processor.total
end
if(total > 0)
  doc.write('show_char_boxes.pdf', optimize: true)
end
