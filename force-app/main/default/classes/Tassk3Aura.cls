public with sharing class Tassk3Aura {
    @AuraEnabled
    public static List<Account> searchAccounts(String searchKey) {
        return [SELECT Id, Name FROM Account WHERE Name LIKE :('%' + searchKey + '%') LIMIT 10];
    }

    @AuraEnabled
    public static Map<String, Object> getContactsByAccountId(Id accountId) {
        List<Contact> contacts = [SELECT Id, Name FROM Contact WHERE AccountId = :accountId];
        Integer contactCount = [SELECT COUNT() FROM Contact WHERE AccountId = :accountId];
        System.debug('contact==>'+contacts);
        System.debug('contactCount==>'+contactCount);
        
        Map<String, Object> result = new Map<String, Object>();
        result.put('contacts', contacts);
        result.put('contactCount', contactCount);
        
        return result;
    }

    @AuraEnabled
    public static void updateContactAccount(Id contactId, Id accountId) {
        try {
            Contact contact = [SELECT Id, AccountId FROM Contact WHERE Id = :contactId LIMIT 1];
            contact.AccountId = accountId;
            update contact;
            System.debug(contact);
        } catch (Exception e) {
            throw new AuraHandledException('Unable to update contact: ' + e.getMessage());
        }
    }
}