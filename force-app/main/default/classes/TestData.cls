@isTest
public with sharing class TestData {
    @testSetup
    static void setupData() {
        // Create a test Account
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
        
        // Create test Contacts associated with the test Account
        List<Contact> testContacts = new List<Contact>();
        for (Integer i = 0; i < 5; i++) {
            testContacts.add(new Contact(
                FirstName = 'Test',
                LastName = 'Contact' + i,
                Phone = '1234567890',
                AccountId = testAccount.Id
            ));
        }
        insert testContacts;

        // Create test Company records
        List<Company__c> testCompanies = new List<Company__c>();
        for (Integer i = 0; i < 5; i++) {
            testCompanies.add(new Company__c(
                Name = 'Test Company ' + i,
                Career_Page_URL__c = 'http://testcompany' + i + '.com'
            ));
        }
        insert testCompanies;
    }
    
    @isTest
    static void testGetAccountData() {
        // Retrieve a test Contact
        Contact testContact = [SELECT Id FROM Contact LIMIT 1];
        
        // Test the getAccountData method
        Test.startTest();
        List<Contact> result = Data.getAccountData(testContact.Id);
        Test.stopTest();
        
        // Verify that the result is as expected
        System.assertEquals(1, result.size(), 'Expected to retrieve 1 Contact');
        System.assertEquals(testContact.Id, result[0].Id, 'Expected to retrieve the correct Contact');
    }
    
    @isTest
    static void testCompany() {
        // Test the Company method
        Test.startTest();
        List<Company__c> result = Data.Company();
        Test.stopTest();
        
        // Verify that the result is as expected
        System.assertEquals(5, result.size(), 'Expected to retrieve 5 Companies');
    }

    @isTest
    static void testExceptionHandling() {
        // Test exception handling for getAccountData method
        Test.startTest();
        try {
            Data.getAccountData(null);
            System.assert(false, 'Expected an exception to be thrown');
        } catch (AuraHandledException e) {
            System.assert(e.getMessage().contains('System.QueryException'), 'Expected a QueryException');
        }
        Test.stopTest();
        
        // Test exception handling for Company method
        Test.startTest();
        try {
            // Simulate an exception by invoking the method with a condition that throws an error
            List<Company__c> result = [SELECT Id FROM Company__c LIMIT 1];
            delete result;
            Data.Company();
            System.assert(false, 'Expected an exception to be thrown');
        } catch (AuraHandledException e) {
            System.assert(e.getMessage().contains('System.QueryException'), 'Expected a QueryException');
        }
        Test.stopTest();
    }
}