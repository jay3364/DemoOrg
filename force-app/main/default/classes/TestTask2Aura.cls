@isTest
public class TestTask2Aura {
    @isTest
    static void testGetAccounts() {
        
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 25; i++) {
            accounts.add(new Account(Name = 'Test Account ' + i));
        }
        insert accounts;

        
        Integer pageNumber = 1;
        Integer pageSize = 10;

        Test.startTest();
        List<Account> result = Task2Aura.getAccounts(pageNumber, pageSize);
        Test.stopTest();

        
        System.assertNotEquals(null, result, 'Accounts should not be null');
        System.assertEquals(pageSize, result.size(), 'Page size should be ' + pageSize);
    }

    @isTest
    static void testGetContacts() {
        
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < 5; i++) {
            contacts.add(new Contact(LastName = 'Test Contact ' + i, AccountId = acc.Id));
        }
        insert contacts;

        Test.startTest();
        List<Contact> result = Task2Aura.getContacts(acc.Id);
        Test.stopTest();

        
        System.assertNotEquals(null, result, 'Contacts should not be null');
        System.assertEquals(5, result.size(), 'There should be 5 contacts');
    }

    @isTest
    static void testGetAccountCount() {
        
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 15; i++) {
            accounts.add(new Account(Name = 'Test Account ' + i));
        }
        insert accounts;

        Test.startTest();
        Integer count = Task2Aura.getAccountCount();
        Test.stopTest();

        
        System.assertEquals(15, count, 'The count of accounts should be 15');
    }

    @isTest
    static void testSearchAccounts() {
        
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 20; i++) {
            accounts.add(new Account(Name = 'Search Test Account ' + i));
        }
        insert accounts;

        Test.startTest();
        Map<String, Object> result = Task2Aura.searchAccounts('Search Test');
        Test.stopTest();

        
        System.assertNotEquals(null, result, 'Result map should not be null');
        List<Account> foundAccounts = (List<Account>) result.get('accounts');
        Integer totalPages = (Integer) result.get('totalPages');

        System.assertNotEquals(null, foundAccounts, 'Accounts list should not be null');
        System.assert(foundAccounts.size() > 0, 'There should be some accounts returned');
        System.assert(totalPages > 0, 'Total pages should be greater than 0');
    }
}