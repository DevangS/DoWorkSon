class TextController < ApplicationController
  include TextHelper

  #handles recieving an SMS reply
  def receivedtext
    message_body = params["Body"]
    from_number = params["From"]
 
    handle_reply(from_number, message_body)
  end
end
