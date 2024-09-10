trigger Task5 on Account (after update) {
    //Write a trigger so that whenever an account name is modified, send an email notification to the contact of an Account
     if(Trigger.isUpdate && Trigger.isAfter)
    {
        TriggerHandler5.handleBeforeUpdate(Trigger.new,Trigger.oldMap);
        /*for(Account ac : Trigger.new)
        {
            if(ac.Name != Trigger.oldMap.get(ac.Id).Name)
            {
               sendNotification(Trigger.newMap);
            } 
        }

    }
    
     public static void sendNotification(Map<Id,Account> accMap) {
       List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
       system.debug('accMap--'+accMap.keyset());
          System.debug('this is start Account Email');
        
        if (accMap.keyset().size() > 0) {
            List<Contact> conList = [SELECT Id, Name, Email FROM Contact WHERE Email != null AND AccountId IN :accMap.keyset()];
  
            if (conList.size() > 0) {
                List<String> conEmail = new List<String>();
                
                for (Contact con : conList) {
                    conEmail.add(con.Email);
                }
         
        
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(conEmail);
                mail.setReplyTo(UserInfo.getUserEmail());
                mail.setSubject('Account Name Change');
                String body = 'Hi!, ';
                body += 'Your Account has been changed.';
                mail.setHtmlBody(body);
                mails.add(mail);
            }
        }
        Messaging.SendEmailResult[] results = Messaging.sendEmail(mails);
        inspectResults(results);
    }
    
    private static void inspectResults(Messaging.SendEmailResult[] results) {
        for (Messaging.SendEmailResult res : results) {
            if (res.isSuccess()) {
                System.debug('Email sent successfully');
            }
            else {
                System.debug('The following errors occurred: ' + res.getErrors());                 
            }
        }*/
}
}