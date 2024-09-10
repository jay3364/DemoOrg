public with sharing class Task1LWC {
    @AuraEnabled
    public static void insertContact(Contact contact){
      
        System.debug(contact);
        insert contact;

    }
}