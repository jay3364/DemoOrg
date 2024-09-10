@isTest
public class TestTrigger14 {
    @isTest
    static void testContactInsert() {
        
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        Contact con = new Contact(AccountId = acc.Id, LastName = 'Test Contact', Amount__c = 100);
        //List<Contact> conList = new List<Contact>();
        //conList.add(con);

        Test.startTest();
        insert con;
        Test.stopTest();

        
        acc = [SELECT Total_Amount__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals(100, acc.Total_Amount__c, 'Total_Amount__c should be updated correctly after Contact insert.');
    }

    @isTest
    static void testContactUpdate() {
        // Create an account
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        
        Contact con = new Contact(AccountId = acc.Id, LastName = 'Test Contact', Amount__c = 100);
        insert con;

       
        con.Amount__c = 150;
        List<Contact> conList = new List<Contact>();
        conList.add(con);
        Map<Id, Contact> oldMap = new Map<Id, Contact>();
        oldMap.put(con.Id, new Contact(Id = con.Id, AccountId = acc.Id, Amount__c = 100));

        Test.startTest();
        update con;
     
        Test.stopTest();

        
        acc = [SELECT Total_Amount__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals(150, acc.Total_Amount__c, 'Total_Amount__c should be updated correctly after Contact update.');
    }

    @isTest
    static void testContactDelete() {
       
        Account acc = new Account(Name = 'Test Account');
        insert acc;

    
        Contact con = new Contact(AccountId = acc.Id, LastName = 'Test Contact', Amount__c = 100);
        insert con;

        Map<Id, Contact> oldMap = new Map<Id, Contact>();
        oldMap.put(con.Id, con);

        Test.startTest();
        delete con;
        
        Test.stopTest();

        
        acc = [SELECT Total_Amount__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals(0, acc.Total_Amount__c, 'Total_Amount__c should be updated correctly after Contact delete.');
    }

    @isTest
    static void testContactUndelete() {
       
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        
        Contact con = new Contact(AccountId = acc.Id, LastName = 'Test Contact', Amount__c = 100);
        insert con;

        delete con;

        List<Contact> conList = new List<Contact>();
        conList.add(con);

        Test.startTest();
        undelete con;
      
        Test.stopTest();

       
        acc = [SELECT Total_Amount__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals(100, acc.Total_Amount__c, 'Total_Amount__c should be updated correctly after Contact undelete.');
    }
}