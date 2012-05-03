module MailgunWebhooks
  module Rails
    class Railtie < ::Rails::Railtie
      initializer "mailgun_webhooks.insert_middleware" do |app|
        app.config.middleware.use "MailgunWebhooks::Rack"
      end
    end
  end
end
