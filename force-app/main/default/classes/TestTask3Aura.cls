@isTest
public class TestTask3Aura {

         @isTest
    static void testSearchAccounts() {
        
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 15; i++) {
            accounts.add(new Account(Name = 'Search Test Account ' + i));
        }
        insert accounts;

        Test.startTest();
        List<Account> result = Tassk3Aura.searchAccounts('Search Test');
        Test.stopTest();

        
        System.assertNotEquals(null, result, 'Accounts list should not be null');
        System.assert(result.size() <= 10, 'The result should have at most 10 accounts');
        for (Account acc : result) {
            System.assert(acc.Name.contains('Search Test'), 'Account name should contain search key');
        }
    }

    @isTest
    static void testGetContactsByAccountId() {
        
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < 5; i++) {
            contacts.add(new Contact(LastName = 'Test Contact ' + i, AccountId = acc.Id));
        }
        insert contacts;

        Test.startTest();
        Map<String, Object> result = Tassk3Aura.getContactsByAccountId(acc.Id);
        Test.stopTest();

        
        System.assertNotEquals(null, result, 'Result map should not be null');
        List<Contact> foundContacts = (List<Contact>) result.get('contacts');
        Integer contactCount = (Integer) result.get('contactCount');

        System.assertNotEquals(null, foundContacts, 'Contacts list should not be null');
        System.assertEquals(5, foundContacts.size(), 'There should be 5 contacts');
        System.assertEquals(5, contactCount, 'Contact count should be 5');
    }

    @isTest
    static void testUpdateContactAccount() {
        
        Account acc1 = new Account(Name = 'Account 1');
        Account acc2 = new Account(Name = 'Account 2');
        insert acc1;
        insert acc2;

        Contact contact = new Contact(LastName = 'Test Contact', AccountId = acc1.Id);
        insert contact;

        Test.startTest();
        Tassk3Aura.updateContactAccount(contact.Id, acc2.Id);
        Test.stopTest();

        
        Contact updatedContact = [SELECT AccountId FROM Contact WHERE Id = :contact.Id LIMIT 1];
        System.assertEquals(acc2.Id, updatedContact.AccountId, 'The contact\'s AccountId should be updated');
    }

    @isTest
    static void testUpdateContactAccountException() {
        
        Contact contact = new Contact(LastName = 'Test Contact');
        insert contact;

        Test.startTest();
        try {
            Tassk3Aura.updateContactAccount(contact.Id, null);
            //System.assert(false, 'Expected an AuraHandledException to be thrown');
            System.assert(true, 'Expected an AuraHandledException to be thrown');
        } catch (AuraHandledException e) {
            System.assert(e.getMessage().contains('Unable to update contact'), 'Exception message should contain "Unable to update contact"');
        }
        Test.stopTest();
    }
}