public with sharing class task3lwc {
   public static list<Account> acclist(){
    return [SELECT Id,Name from Account];
   }
 @AuraEnabled(cacheable=true)
    public static List<sObject> getRecordObject(String objectName){
       String query;
        if (String.isBlank(objectName)) {
            throw new IllegalArgumentException('Object name cannot be blank');
        }
        if(objectName == 'Contact'){
         query = 'SELECT Id, Name, Email, CreatedDate, LastModifiedDate FROM ' + objectName + ' LIMIT 10';
        }
        if(objectName == 'Account' ){
         query = 'SELECT Id, Name,Email__c, CreatedDate, LastModifiedDate FROM ' + objectName + ' LIMIT 10';
        }
        if(objectName == 'Opportunity' ){
         query = 'SELECT Id, Name,Email__c, CreatedDate, LastModifiedDate FROM ' + objectName + ' LIMIT 10';
        }
       
        try {
            return Database.query(query);
        
        } catch(Exception e) {
            throw new AuraHandledException('Error fetching records: ' + e.getMessage());
        }
    }

     @AuraEnabled
    public static void sendEmail(String subject, String recipient, String body) {
        
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();

        
        email.setSubject(subject);
        email.setToAddresses(new String[] { recipient });
        email.setPlainTextBody(body);

       
        try {
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
        } catch (Exception e) {
            System.debug('Error sending email: ' + e.getMessage());
            throw new AuraHandledException('Failed to send email.');
        }
    }

   
    
}