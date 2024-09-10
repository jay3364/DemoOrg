public with sharing class Data {
    public Data() {

    }
    
        @AuraEnabled(cacheable=true)
        public static List<Contact> getAccountData(Id recordId) {

            try {
                System.debug('Fetching Account Data'+recordId);
                List<Contact> AccData = [SELECT Id, Name, Phone  FROM Contact WHERE Id = :recordId LIMIT 5];
                System.debug('Retrieved Accounts: ' + AccData);
                return AccData;
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }
    
    

    @AuraEnabled(cacheable=true)
    public static list<Company__c> Company(){
        try {
            List<Company__c>AccData = [select Id,Name,Career_Page_URL__c from Company__c limit 5];
            return AccData;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}