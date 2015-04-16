# this little trick moves the missing styles to the assets
# so when you update them, they actually update in the client
Paperclip.interpolates(:placeholder) do |attachment, style|
  ActionController::Base.helpers.asset_path("missing_#{style}.png")
end
Paperclip::Attachment.default_options[:default_url] = ":placeholder"

Paperclip::Attachment.default_options[:styles] = {:thumb => '48x48>', :list => '150x150>', :product  => '600x600>' }
Paperclip::Attachment.default_options[:default_style] = :list
Paperclip::Attachment.default_options[:url] = "/images/:id/:style/:basename.:extension"

