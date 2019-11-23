#!/usr/bin/env ruby
require 'httparty'
require 'hexapdf'

response = HTTParty.get("https://rubydesign.fi/api/purchase.json")
items = {}
response.parsed_response["items"].each do |item|
  items[item["scode"]] = item["quantity"]
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
    number = @items[ boxes.string ]
    return unless number
    x, y = *boxes.lower_left
    @canvas.font('Courier', size: 8)
    @canvas.text( number.to_s , at: [x - 23 , y + 3])
    @total += number.to_s.to_i
  end
  alias :show_text_with_positioning :show_text
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
