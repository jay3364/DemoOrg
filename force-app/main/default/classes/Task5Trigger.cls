public class Task5Trigger {
    public static void sendNotification(List<Account> accList, Map<Id, Account> accMap) {
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        Set<Id> accId = new Set<Id>();
        System.debug('this is start Account Email');
        for (Account acc : accList) {
            if (acc.Name != accMap.get(acc.Id).Name) {
                accId.add(acc.Id);
            }
        }
        
        if (accId.size() > 0) {
            List<Contact> conList = [SELECT Id, Name, Email FROM Contact WHERE Email != null AND AccountId IN :accId];
            
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
        
        Messaging.sendEmail(mails);
        System.debug('send mail successfull');
    }
}