class TextController < ApplicationController

  #handles recieving an SMS reply
  def index
    message_body = params["Body"]
    from_number = params["From"]
 
    handle_reply from_number, message_body
  end

  #handles sending an SMS
  def sendtext
  	number_to_send_to = params[:number_to_send_to]
  	chore = Chore.find(params[:chore_id])

  	header = "Reminder: " + chore.description
    response_template = "Reply with Y - Yes/N - No/O - Opt Out and " + chore.id + " eg. Y " + chore.id
    message = header + " " + response_template
    
    twilio_sid = "abc123"
    twilio_token = "foobar"
    twilio_phone_number = "5555555555"
 
    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
 
    @twilio_client.account.sms.messages.create(
      :from => "+1#{twilio_phone_number}",
      :to => number_to_send_to,
      :body => message
    )
  end

  def handle_reply from_number message_body
  	#parse the message_body
  	user_response = message_body.split(' ')[0]
  	chore_id = message_body.split(' ')[1]
  	
  	sender = Persons.where(:phone => from_number)
  	chore = Chores.find(chore_id)

  	case user_response
  	when "Y"
  		#Mark completed
  	when "N"
  		#Mark not completed yet, remind again in 10 mins or so
  	when "O"
  		#Not going to do it so remove from chore
  end

end
