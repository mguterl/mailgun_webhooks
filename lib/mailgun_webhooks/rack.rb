module MailgunWebhooks
  class Rack

    def initialize(app)
      @app = app
    end

    def call(env)
      request = ::Rack::Request.new(env)
      params = request.params

      if request.path == MailgunWebhooks.endpoint
        MailgunWebhooks.trigger(params['event'], params)
        [200, {}, []]
      else
        @app.call(env)
      end
    end

  end
end
