require 'reloader/sse'

class BrowserController < ApplicationController
  include ActionController::Live

  def index
    # SSE expects the `text/event-stream` content type
    response.headers['Content-Type'] = 'text/event-stream'

    sse = Reloader::SSE.new(response.stream)

    begin
      i = 0
      loop do
        i += 1
        if i % 18 == 0
          sse.write({message: "#{i} is divided by 18!!!"}, :event => 'refresh')
        end
        sleep 0.2
      end
    rescue IOError
      # When the client disconnects, we'll get an IOError on write
    ensure
      sse.close
    end
  end
end
