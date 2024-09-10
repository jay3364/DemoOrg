@isTest
public class TestTask3Lwc {
    
    @isTest
    static void testGetRecordObject() {
        task3lwc.acclist();

        Account acc = new Account(Name = 'Test Account', Email__c = 'test@example.com');
        insert acc;
        
        Contact con = new Contact(FirstName = 'Test', LastName = 'Contact', Email = 'test.contact@example.com');
        insert con;
        
        Opportunity opp = new Opportunity(Name = 'Test Opportunity', CloseDate = System.today().addMonths(1), StageName = 'Prospecting');
        insert opp;
        
        Test.startTest();
        
        
        List<sObject> accounts = task3lwc.getRecordObject('Account');
        System.debug('Accounts: ' + accounts);
        System.assertEquals(1, accounts.size(), 'Expected one account record');
        
        
        List<sObject> contacts = task3lwc.getRecordObject('Contact');
        System.debug('Contacts: ' + contacts);
        System.assertEquals(1, contacts.size(), 'Expected one contact record');
        
        
        List<sObject> opportunities = task3lwc.getRecordObject('Opportunity');
        System.debug('Opportunities: ' + opportunities);
        System.assertEquals(1, opportunities.size(), 'Expected one opportunity record');
        
        Test.stopTest();
    }
    
    @isTest
    static void testSendEmail() {
        Test.startTest();
        
        
        try {
            task3lwc.sendEmail('Test Subject', 'test@example.com', 'Test body content');
            // Note: Email sending cannot be directly verified in a test class.
        } catch (Exception e) {
            System.assert(false, 'Exception occurred while sending email: ' + e.getMessage());
        }
        
        
        try {
            task3lwc.sendEmail(null, 'test@example.com', 'Test body content');
            System.assert(false, 'Exception should be thrown for null subject');
        } catch (AuraHandledException e) {
            System.assert(true, 'Expected exception occurred for null subject');
        }
        
        
        try {
            task3lwc.sendEmail('Test Subject', null, 'Test body content');
            System.assert(false, 'Exception should be thrown for null recipient');
        } catch (AuraHandledException e) {
            System.assert(true, 'Expected exception occurred for null recipient');
        }
        
        Test.stopTest();
    }
}