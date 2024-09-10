@isTest
public class TestTask1Aura {

    @isTest
    public static void TestSaveContactRecord(){
        Test.startTest();
            Task1Aura.saveContactRecord(new contact(LastName = 'testContect'));  	
        Test.stopTest();
        
    }
    
    @isTest
     static void testSaveContactRecordException() {
        
        Contact invalidContact = new Contact(Email = 'invalid@example.com');

        Test.startTest();
        try {
            Task1Aura.saveContactRecord(invalidContact);
            System.assert(false, 'Expected an exception to be thrown');
        } catch (AuraHandledException e) {
            System.assert(e.getMessage().contains('Error saving contact'));
        }
        Test.stopTest();
    }
}