class MailWorker < ActionMailer::Base
  
   def verification(recipient, sent_at = Time.now)
      @subject = subject
      @recipients = recipient
      @from = 'MailWorker@haikufire.com'
      @sent_on = sent_at
        @body["title"] = 'Welcome to Haikufire!'
        @body["email"] = 'MailWorker@haikufire.com'
   end

end
