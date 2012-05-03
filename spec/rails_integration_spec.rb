require 'spec_helper'
require 'mailgun_webhooks/rails/railtie'

describe 'MailgunWebhooks Integration' do

  include RSpec::Rails::RequestExampleGroup

  it 'executes triggers webhooks via the rails application' do
    MailgunWebhooks.api_key = 'asdf1234'

    recipient = nil
    MailgunWebhooks.on(:bounced) do |data|
      recipient = data['recipient']
    end

    payload = {
      :event     => 'bounced',
      :api_key   => 'asdf1234',
      :token     => 'token',
      :timestamp => '1331843491',
      :signature => '58f947e0fb92f40c6a2379c948c2ce57d518f8b4d18bc47c15daa0abc2c527ca',
      :recipient => 'foo@example.org',
    }

    post '/mailgun', payload
    recipient.should == 'foo@example.org'
  end

end
