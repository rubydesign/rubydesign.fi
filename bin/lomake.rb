#!/usr/bin/env ruby

require 'hexapdf'

class ShowTextProcessor < HexaPDF::Content::Processor

  def initialize(page)
    super()
    @canvas = page.canvas(type: :overlay)
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

api = 
doc = HexaPDF::Document.open(ARGV.shift)
doc.pages.each_with_index do |page, index|
  puts "Sivu #{index + 1} #{file}"
  processor = ShowTextProcessor.new(page)
  page.process_contents(processor)
end
doc.write('show_char_boxes.pdf', optimize: true)
