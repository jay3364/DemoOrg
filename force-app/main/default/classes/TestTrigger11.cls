@isTest
public class TestTrigger11 {
    @isTest
    static void testCreateEventsForContacts() {
        // Create test contacts
        List<Contact> testContacts = new List<Contact>();
        for (Integer i = 0; i < 5; i++) {
            Contact con = new Contact(
                LastName = 'TestLastName ' + i,
                FirstName = 'TestFirstName ' + i
            );
            testContacts.add(con);
        }

        // Insert test contacts
         
        Test.startTest();
        insert testContacts;
       	//TriggerHandler11.triggerHandle(testContacts);
        Test.stopTest();
		 
        // Query created events
        List<Event> createdEvents = [SELECT Id, Subject, StartDateTime, EndDateTime, WhoId FROM Event WHERE WhoId IN :testContacts];

        // Assertions
        System.assertEquals(testContacts.size(), createdEvents.size(), 'Number of events should match number of contacts');

        Map<Id, Contact> contactMap = new Map<Id, Contact>(testContacts);

        for (Event ev : createdEvents) {
            String expectedSubjectPrefix = 'Meeting with TestLastName ';
            System.assert(ev.Subject.startsWith(expectedSubjectPrefix), 'Event Subject should start with "Meeting with TestLastName"');
            System.assert(contactMap.containsKey(ev.WhoId), 'Event should be linked to a test contact');
            System.assert(ev.StartDateTime != null, 'Event StartDateTime should not be null');
            System.assert(ev.EndDateTime != null, 'Event EndDateTime should not be null');
        }
    }
}