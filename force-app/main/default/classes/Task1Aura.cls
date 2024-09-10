public with sharing class Task1Aura {

    @AuraEnabled
    public static void saveContactRecord(Contact contact) {
        try {
            insert contact;
        } catch (Exception e) {
            throw new AuraHandledException('Error saving contact: ' + e.getMessage());
        }
    }
}