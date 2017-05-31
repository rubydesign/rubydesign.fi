Rails.application.config do

  config.assets.precompile += %w( office_clerk.js office_clerk.css)

  (Rails::Engine.subclasses.map(&:instance) << Rails.application).each do |e|
    next unless e.respond_to? :office_assets
    asset = e.office_assets
    next if asset.blank?
    config.assets.precompile << (asset + ".js")
    config.assets.precompile << (asset + ".css")
  end

end
