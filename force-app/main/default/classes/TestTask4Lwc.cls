@isTest
public class TestTask4Lwc {
    @isTest
    static void testGetAccList() {
        
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        Test.startTest();
        
        List<Account> accounts = Task4Lwc.getaccList();
        System.debug('Accounts: ' + accounts);
        System.assertNotEquals(0, accounts.size(), 'Expected at least one account record');
        
        Test.stopTest();
    }
    
    @isTest
    static void testOppList() {
        
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        
        Contact con = new Contact(FirstName = 'Test', LastName = 'Contact', Email = 'test.contact@example.com', AccountId = acc.Id);
        insert con;
        
        Opportunity opp = new Opportunity(Name = 'Test Opportunity', Amount = 1000, StageName = 'Prospecting', CloseDate = System.today().addMonths(1), AccountId = acc.Id);
        insert opp;
        
        Test.startTest();
        
        Map<String, List<sObject>> recordMap = Task4Lwc.oppList(acc.Id);
        System.debug('Record Map: ' + recordMap);
        
        List<Contact> contacts = (List<Contact>) recordMap.get('contact');
        List<Opportunity> opportunities = (List<Opportunity>) recordMap.get('opo');
        
        System.assertNotEquals(0, contacts.size(), 'Expected at least one contact record');
        System.assertNotEquals(0, opportunities.size(), 'Expected at least one opportunity record');
        
        Test.stopTest();
    }
     @isTest
    static void testGetAllObjects() {
        Test.startTest();
        
        List<EntityDefinition> entityDefinitions = Task4Lwc.getAllObjects();
        System.debug('Entity Definitions: ' + entityDefinitions);
        System.assertNotEquals(0, entityDefinitions.size(), 'Expected at least one customizable object');
        
        Test.stopTest();
    }
    
    @isTest
    static void testSearchObjects() {
        
        Account acc = new Account(Name = 'Search Test Account');
        insert acc;
        
        Contact con = new Contact(FirstName = 'Search', LastName = 'Contact', Email = 'search.contact@example.com', AccountId = acc.Id);
        insert con;
        
        Opportunity opp = new Opportunity(Name = 'Search Opportunity', Amount = 1000, StageName = 'Prospecting', CloseDate = System.today().addMonths(1), AccountId = acc.Id);
        insert opp;
        
        List<String> selectedObjects = new List<String>{'Contact', 'Opportunity'};
        
        Test.startTest();
        
        Map<String, List<sObject>> searchResults = Task4Lwc.searchObjects('Search', selectedObjects);
        System.debug('Search Results: ' + searchResults);
        
        List<Contact> contacts = (List<Contact>) searchResults.get('Contact');
        List<Opportunity> opportunities = (List<Opportunity>) searchResults.get('Opportunity');
        
        System.assertNotEquals(0, contacts.size(), 'Expected at least one contact record');
        System.assertNotEquals(0, opportunities.size(), 'Expected at least one opportunity record');
        
        Test.stopTest();
    }
    
    @isTest
    static void testRecordGet() {
        
        Account acc = new Account(Name = 'Record Get Account');
        insert acc;
        
        Contact con = new Contact(FirstName = 'Record', LastName = 'Contact', Email = 'record.contact@example.com', AccountId = acc.Id);
        insert con;
        
        Opportunity opp = new Opportunity(Name = 'Record Get Opportunity', Amount = 1000, StageName = 'Prospecting', CloseDate = System.today().addMonths(1), AccountId = acc.Id);
        insert opp;
        
        List<String> objectNames = new List<String>{'Account', 'Contact', 'Opportunity'};
        
        Test.startTest();
        
        List<List<sObject>> records = Task4Lwc.recordget(objectNames);
        System.debug('Records: ' + records);
        
        System.assertEquals(3, records.size(), 'Expected results for three objects');
        
        List<Account> accounts = (List<Account>) records[0];
        List<Contact> contacts = (List<Contact>) records[1];
        List<Opportunity> opportunities = (List<Opportunity>) records[2];
        
        System.assertNotEquals(0, accounts.size(), 'Expected at least one account record');
        System.assertNotEquals(0, contacts.size(), 'Expected at least one contact record');
        System.assertNotEquals(0, opportunities.size(), 'Expected at least one opportunity record');
        
        Test.stopTest();
    }
}