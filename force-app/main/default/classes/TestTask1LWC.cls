@isTest
public class TestTask1LWC {
 @IsTest
    static void testInsertContact() {
        
        Contact testContact = new Contact();
        testContact.LastName = 'TestLastName';
        testContact.Email = 'test@example.com';
        
        Test.startTest();
        Task1LWC.insertContact(testContact);
        Test.stopTest();

        Contact insertedContact = [SELECT Id, LastName, Email FROM Contact WHERE Email = :testContact.Email LIMIT 1];

        
        System.assertNotEquals(null, insertedContact, 'The contact should have been inserted.');
        System.assertEquals(testContact.LastName, insertedContact.LastName, 'The Last Name should match the inserted value.');
        System.assertEquals(testContact.Email, insertedContact.Email, 'The Email should match the inserted value.');
    }

    @IsTest
    static void testInsertContactException() {
       
        Contact testContact = new Contact();
        testContact.Email = 'test_exception@example.com';

        Test.startTest();
        try {
            Task1LWC.insertContact(testContact);
            System.assert(false, 'Expected exception was not thrown.');
        } catch (Exception e) {
            System.assertEquals('System.DmlException: Insert failed. First exception on row 0; first error: REQUIRED_FIELD_MISSING, Required fields are missing: [LastName]: [LastName]', e.getMessage(), 'The exception message should indicate a missing LastName.');
        }
        Test.stopTest();
    }
}