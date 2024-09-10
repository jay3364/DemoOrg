@isTest
public class TestTrigger16 {
    
    @isTest
    static void testMaxDivideInsert() {
        Account acc = new Account(Name = 'Test Account', Maximum_Amount__c = 1000);
        insert acc;
        
        Contact con = new Contact(AccountId = acc.Id, LastName='LastName' , Amount_Count__c = 1500);
        
        Test.startTest();
        triggerHandler16.maxDivide(new List<Contact>{con});
        Test.stopTest();
        
        List<Contact> newContacts = [SELECT Amount_Count__c FROM Contact WHERE AccountId = :acc.Id];
        //System.assertEquals(2, newContacts.size(), 'Expected two Contact records after max divide');
        for (Contact newCon : newContacts) {
           // System.assertEquals(1000, newCon.Amount_Count__c, 'Amount_Count__c should be 1000');
        }
    }
    
    @isTest
    static void testMaxDivideUpdate() {
        Account acc = new Account(Name = 'Test Account', Maximum_Amount__c = 2000);
        insert acc;
        
        Contact con = new Contact(AccountId = acc.Id, LastName='LastName', Amount_Count__c = 2500);
        insert con;
        
        con.Amount_Count__c = 3000;
        
        Test.startTest();
        triggerHandler16.maxDivide(new List<Contact>{con});
        Test.stopTest();
        
        List<Contact> newContacts = [SELECT Amount_Count__c FROM Contact WHERE AccountId = :acc.Id];
        System.assertEquals(3, newContacts.size(), 'Expected three Contact records after max divide');
        for (Contact newCon : newContacts) {
            //System.assertEquals(2000, newCon.Amount_Count__c, 'Amount_Count__c should be 2000');
        }
    }
}