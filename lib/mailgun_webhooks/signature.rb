require 'openssl'

module MailgunWebhooks
  class Signature
    # Public: Verifies the incoming data according to the MailgunWebhooks specs:
    # http://documentation.mailgun.net/user_manual.html#events-webhooks
    #
    # Returns a boolean.
    def self.valid?(data)
      signature = data.fetch('signature')
      api_key   = data.fetch('api_key')
      timestamp = data.fetch('timestamp')
      token     = data.fetch('token')
      digest    = OpenSSL::Digest.new('sha256')

      signature == OpenSSL::HMAC.hexdigest(digest,
                                           api_key,
                                           '%s%s' % [timestamp, token])
    end

  end
end
