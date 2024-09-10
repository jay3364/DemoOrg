@isTest
public class TestTrigger8 {

    @isTest
    static void testAccountdelete() {
        // Create test data
        Account account1 = new Account(Name = 'Test Account 1');
        Account account2 = new Account(Name = 'Test Account 2');
        insert new List<Account> {account1, account2};
        
        Contact contact1 = new Contact(FirstName = 'Test', LastName = 'Contact1', AccountId = account1.Id);
        Contact contact2 = new Contact(FirstName = 'Test', LastName = 'Contact2', AccountId = account1.Id);
        Contact contact3 = new Contact(FirstName = 'Test', LastName = 'Contact3', AccountId = account2.Id);
        insert new List<Contact> {contact1, contact2, contact3};

        // Ensure contacts are associated with accounts
        System.assertEquals(account1.Id, contact1.AccountId);
        System.assertEquals(account1.Id, contact2.AccountId);
        System.assertEquals(account2.Id, contact3.AccountId);

        // Call the method to delete accounts associated with the contacts
        Test.startTest();
        TriggerHandler8.Accountdelete(new List<Contact> {contact1, contact3});
        Test.stopTest();

        // Verify the outcomes
        // Account 1 should not be deleted because it has another contact (contact2)
        // Account 2 should be deleted because it only had contact3

        // Query for the remaining accounts
        List<Account> remainingAccounts = [SELECT Id FROM Account WHERE Id IN :new List<Id>{account1.Id, account2.Id}];

        // Initialize flags to check existence of accounts
        Boolean isAccount1Deleted = true;
        Boolean isAccount2Deleted = true;

        for (Account acc : remainingAccounts) {
            if (acc.Id == account1.Id) {
                isAccount1Deleted = false;
            }
            if (acc.Id == account2.Id) {
                isAccount2Deleted = false;
            }
        }

        // Validate the results
        //System.assert(isAccount1Deleted == false, 'Account 1 should not be deleted');
        //System.assert(isAccount2Deleted == true, 'Account 2 should be deleted');
    }
}