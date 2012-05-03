# We have to load spec_helper here otherwise, the engine isn't loaded
# properly for the rails_integration_spec. It would be nice to fix
# this, but I'm too lazy to diagnose. Replace 'spec_helper' with
# 'mailgun_webhooks' to reproduce.
require 'spec_helper'

describe MailgunWebhooks do
  it 'stores the api host' do
    MailgunWebhooks.api_host = 'example.org'
    MailgunWebhooks.api_host.should == 'example.org'
  end

  it 'stores the api key' do
    MailgunWebhooks.api_key = 'asdf1234'
    MailgunWebhooks.api_key.should == 'asdf1234'
  end

  describe '.trigger' do
    context 'when signature is valid' do
      before { MailgunWebhooks::Signature.stub(:valid?) { true } }

      it 'triggers the webhook' do
        value = 0
        MailgunWebhooks.on(:foo) { |data| value += data[:count] }
        MailgunWebhooks.trigger(:foo, :count => 1)

        value.should == 1
      end
    end

    context 'when signature is invalid' do
      before { MailgunWebhooks::Signature.stub(:valid?) { false } }

      it 'raises an error' do
        expect {
          MailgunWebhooks.trigger(:foo, :count => 1)
        }.to raise_error(MailgunWebhooks::InvalidSignature)
      end
    end
  end
end
