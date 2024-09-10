@isTest
public class TestTask4Aura {

    @isTest
    static void testCreateRecords() {
        
        Account acc = new Account(Name = 'Test Account');
        Contact con = new Contact(LastName = 'Test Contact');
        Event evt = new Event(Subject = 'Test Event', StartDateTime = System.now(), EndDateTime = System.now().addHours(1));

        Test.startTest();
        Map<String, Id> result = Task4Aura.createRecords(acc, con, evt);
        Test.stopTest();

        
        System.assertNotEquals(null, result, 'Result map should not be null');
        System.assert(result.containsKey('AccountId'), 'Result map should contain AccountId');
        System.assert(result.containsKey('ContactId'), 'Result map should contain ContactId');
        System.assert(result.containsKey('EventId'), 'Result map should contain EventId');

        
        Account insertedAccount = [SELECT Id, Name FROM Account WHERE Id = :result.get('AccountId') LIMIT 1];
        Contact insertedContact = [SELECT Id, AccountId, LastName FROM Contact WHERE Id = :result.get('ContactId') LIMIT 1];
        Event insertedEvent = [SELECT Id, Subject, WhoId FROM Event WHERE Id = :result.get('EventId') LIMIT 1];

        
        System.assertEquals(acc.Name, insertedAccount.Name, 'The inserted Account name should match the provided name');
        System.assertEquals(con.LastName, insertedContact.LastName, 'The inserted Contact last name should match the provided name');
        System.assertEquals(result.get('AccountId'), insertedContact.AccountId, 'The Contact should be linked to the correct Account');
        System.assertEquals(evt.Subject, insertedEvent.Subject, 'The inserted Event subject should match the provided subject');
        System.assertEquals(result.get('ContactId'), insertedEvent.WhoId, 'The Event should be linked to the correct Contact');
    }

    @isTest
    static void testCreateRecordsException() {
        
        Account acc = new Account(Name = 'Test Account');
        Contact con = new Contact(LastName = 'Test Contact'); 
        Event evt = new Event(Subject = 'Test Event', StartDateTime = System.now(), EndDateTime = System.now().addHours(1));

        Test.startTest();
        try {
            Task4Aura.createRecords(acc, con, evt);
            System.assert(false, 'Expected an AuraHandledException to be thrown');
        } catch (AuraHandledException e) {
            System.assert(e.getMessage().contains('Error creating records'), 'Exception message should contain "Error creating records"');
        }
        Test.stopTest();
    }
}