public class TriggerHandler5 {
    
    public static void handleBeforeUpdate(List<Account> newAccounts, Map<Id, Account> oldAccountMap) {
        for (Account ac : newAccounts) {
            if (ac.Name != oldAccountMap.get(ac.Id).Name) {
                sendNotification(newAccounts);
            }
        }
    }
    
    public static void sendNotification(List<Account> accList) {
        List<Id> accIds = new List<Id>();
        for (Account acc : accList) {
            accIds.add(acc.Id);
        }
        
        if (!accIds.isEmpty()) {
            List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
            List<Contact> conList = [SELECT Id, Name, Email FROM Contact WHERE Email != null AND AccountId IN :accIds];
            
            if (!conList.isEmpty()) {
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
            
            Messaging.SendEmailResult[] results = Messaging.sendEmail(mails);
            inspectResults(results);
        }
    }
    
    private static void inspectResults(Messaging.SendEmailResult[] results) {
        for (Messaging.SendEmailResult res : results) {
            if (res.isSuccess()) {
                System.debug('Email sent successfully');
            } else {
                System.debug('The following errors occurred: ' + res.getErrors());                 
            }
        }
    }
}