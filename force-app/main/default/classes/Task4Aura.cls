public with sharing class Task4Aura {
    
    @AuraEnabled
    public static Map<String, Id> createRecords(Account account, Contact contact, Event eventObj) {
        Map<String, Id> result = new Map<String, Id>();
        try {
            insert account;
            contact.AccountId = account.Id;
            insert contact;
            eventObj.WhoId = contact.Id;
            insert eventObj;

            result.put('AccountId', account.Id);
            result.put('ContactId', contact.Id);
            result.put('EventId', eventObj.Id);
        } catch (Exception e) {
            throw new AuraHandledException('Error creating records: ' + e.getMessage());
        }
        return result;
    }
}