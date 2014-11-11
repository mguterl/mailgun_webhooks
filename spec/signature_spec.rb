require 'mailgun_webhooks/signature'

describe MailgunWebhooks::Signature do
  subject { MailgunWebhooks::Signature.valid?(options) }
  let(:options) {
    {
      'api_key'   => 'asdf1234',
      'token'     => 'token',
      'timestamp' => '1331843491',
      'signature' => '58f947e0fb92f40c6a2379c948c2ce57d518f8b4d18bc47c15daa0abc2c527ca',
    }
  }

  context 'when valid' do
    it { should be true }
  end

  context 'when invalid' do
    before { options['token'] = 'notken' }
    it { should be false }
  end
end
