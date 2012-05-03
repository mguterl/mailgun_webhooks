require 'mailgun_webhooks/signature'
require 'mailgun_webhooks/webhook_registry'
require 'mailgun_webhooks/rack'

if defined? ::Rails
  require 'mailgun_webhooks/rails/railtie'
end

module MailgunWebhooks
  # Public: Base class for any errors raised from within MailgunWebhooks.
  Error = Class.new(StandardError)

  # Public: Error raised when signature is invalid.
  InvalidSignature = Class.new(Error)

  class << self
    # Public: The Mailgun API key.
    #
    # Returns a String.
    attr_accessor :api_key

    # Public: The Mailgun API host.
    #
    # Returns a String.
    attr_accessor :api_host

    # Public: The endpoint for webhooks.
    #
    # Returns a String.
    attr_accessor :endpoint
  end

  # Set default endpoint.
  self.endpoint = '/mailgun'

  # Make MailgunWebhooks behave like a singleton.
  extend self

  # Public: Add a webhook to the registry.
  #
  # Returns nothing.
  def on(webhook, &block)
    webhooks.on(webhook, &block)
  end

  # Public: Verify the signature of the data and trigger the webhook if it is
  # valid. Raise InvalidSignature if the data signature is not valid.
  #
  # Returns nothing.
  def trigger(webhook, data)
    raise InvalidSignature unless verify_signature(data)

    webhooks.trigger(webhook, data)
  end

  # Public: Helper method to check the validity of the data.
  #
  # Returns a boolean.
  def verify_signature(data)
    Signature.valid?(data.merge(:api_key => api_key))
  end

  # Internal: A WebhookRegistry instance.
  def webhooks
    @webhooks ||= WebhookRegistry.new
  end

end
