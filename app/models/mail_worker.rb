class MailWorker < ActionMailer::Base
  
   def verification(recipient, validation_hash, sent_at = Time.now)
      @validation_hash = validation_hash
      @subject = subject
      @recipient = recipient
      @from = 'MailWorker@haikufire.com'
      @sent_on = sent_at
        @body["title"] = 'Welcome to Haikufire!'
        @body["email"] = 'MailWorker@haikufire.com'
   end

end
