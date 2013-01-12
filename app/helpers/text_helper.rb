module TextHelper	
  #handles sending an SMS
  def sendtext(chore, number_to_send_to, message)
    twilio_sid = "AC95842c9042ee4068ce068b8802f740ca"
    twilio_token = "da31ced4fe37df32c2bd6da66c2c309d"
    twilio_phone_number = "3234542127"
 
    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
 
    @twilio_client.account.sms.messages.create(
      :from => "+1#{twilio_phone_number}",
      :to => number_to_send_to,
      :body => message
    )
  end

  def handle_reply(from_number, message_body)
  	#parse the message_body
  	user_response = message_body.split(' ')[0]
  	chore_id = message_body.split(' ')[1]
  	
  	sender = Person.where(:phone => from_number)
  	chore = Chore.find(chore_id)

  	case user_response
    #Has completed chore, so updated time completed and give next person in line the chore to do
  	when "Y"
  		if chore(:time_completed => Time.now).save
        chore.update_shift
      end
    #Hasn't completed chore, so alert group 
  	when "N"
      alert_failure_to_complete(chore)
    #Not going to do it so remove from chore, and alert group that they opt'd out
  	when "O"
      chore.opt_out_current
      alert_opt_out(chore)
  	end	
  end

  def send_reminders
    #send reminders to do chores
  	Chore.find_chores do |chore|
  		if chore(:time_reminded => Time.now).save
	        message = "Reminder: " + chore.name + ". Reply with Y(Done),N(Not Done),O(Opt Out) and " + chore.id + " eg. Y " + chore.id
	        sendtext(chore, chore.currentPerson.phone, message)
    	end
    end

    #send alerts about lazy people who didn't do their chores
    Chore.find_lazy_chores do |chore|
      if chore(:time_completed => Time.now).save       
        alert_failure_to_complete(chore)
        chore.update_shift
      end
    end
  end

  def alert_group(chore, message)
    chore.people.each do |person|
      sendtext(chore, person.phone, message)
    end
  end

  def alert_group_of_action(chore, action_msg)
    alert_group(chore, chore.currentPerson.name + " " + action_msg + " " + chore.name + "!")
  end

  def alert_failure_to_complete(chore)
    alert_group_of_action(chore,"has failed to complete")
  end

  def alert_opt_out(chore)
    alert_group_of_action(chore, "has opted out of")
  end
end
