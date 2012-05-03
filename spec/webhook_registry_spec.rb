require 'mailgun_webhooks/webhook_registry'

describe MailgunWebhooks::WebhookRegistry do
  it 'stores webhooks for later execution' do
    value = 0
    subject.on(:foo) { |data| value += data[:count] }
    subject.trigger(:foo, :count => 2)

    value.should == 2
  end

  it 'stores multiple webhooks with the same name' do
    value = 0
    subject.on(:foo) { |data| value += data[:count] }
    subject.on(:foo) { |data| value += data[:count] }
    subject.trigger(:foo, :count => 1)

    value.should == 2
  end

  it 'turns strings passed to trigger into symbols' do
    value = 0
    subject.on(:foo) { |data| value += data[:count] }
    subject.trigger('foo', :count => 2)

    value.should == 2
  end

  it 'turns strings passed to on into symbols' do
    value = 0
    subject.on('foo') { |data| value += data[:count] }
    subject.trigger(:foo, :count => 3)

    value.should == 3
  end
end
