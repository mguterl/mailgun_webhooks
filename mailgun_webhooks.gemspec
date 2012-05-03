$:.push File.expand_path("../lib", __FILE__)

require "mailgun_webhooks/version"

Gem::Specification.new do |s|
  s.name        = "mailgun_webhooks"
  s.version     = MailgunWebhooks::VERSION
  s.authors     = ["Michael Guterl"]
  s.email       = ["michael@diminishing.org"]
  s.homepage    = "http://github.com/mguterl/mailgun_webhooks"
  s.summary     = "Rails and Rack integration for Mailgun Webhooks"
  s.description = "Easily add Mailgun Webhook integration to your Rails or Rack application."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_development_dependency "rails", "~> 3.2.3"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
end
