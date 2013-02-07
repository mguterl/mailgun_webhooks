# Mailgun Webhooks

[![Code Climate](https://codeclimate.com/github/mguterl/mailgun_webhooks.png)](https://codeclimate.com/github/mguterl/mailgun_webhooks)

Add support for acting on Mailgun webhooks to your Rack or Rails application.

## Rails Installation

Add `gem 'mailgun_webhooks'` to your Gemfile.

Setup `config/initializers/mailgun.rb`

```ruby
MailgunWebhooks.api_key = "yourapikeyfrommailgun"
MailgunWebhooks.api_host = "yourdomain.com"
```

## Rack Installation

If you wish to use MailgunWebhooks outside of Rails, you can leverage the same middleware used to provide Rails integration. Just add `MailgunWebhooks::Rack` to your middleware stack.

```ruby
use MailgunWebhooks::Rack
```

## Webhooks

By default your application will listen for webhook payloads on `/mailgun`.  You can change this by setting `MailgunWebhooks.endpoint`.

```ruby
MailgunWebhooks.endpoint = '/mailgun_webhooks'
```

In order to customize how your application reacts to webhooks you can define the behavior using `Mailgun.on`.

```ruby
MailgunWebhooks.on(:bounced) do |data|
  # Do something with the incoming data. Check the documentation for details:
  # http://documentation.mailgun.net/user_manual.html#events-webhooks

  if (user = User.find_by_email(data['recipient'])
    user.update_attribute(:email_bounced_at, Time.now)
  end
end
```

**NOTE** It is important to recognize that the hash passed to the block is just a Hash and not a HashWithIndifferentAccess so you have to access the keys as strings, not symbols.
