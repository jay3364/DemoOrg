@isTest
public class TestTriggerHandler10 {
    @isTest
    static void testTriggerHandle() {
     
        List<Account> testAccounts = new List<Account>();
        for (Integer i = 0; i < 5; i++) {
            Account acc = new Account(
                Name = 'Test Account ' + i
            );
            testAccounts.add(acc);
        }
        
   
        Test.startTest();
        insert testAccounts;
        Test.stopTest();

       
        List<Contact> createdContacts = [SELECT Id, LastName, AccountId FROM Contact WHERE AccountId IN :testAccounts];
        
      
        System.assertEquals(testAccounts.size(), createdContacts.size(), 'Number of contacts should match number of accounts');

        Map<Id, Account> accountMap = new Map<Id, Account>(testAccounts);

        for (Contact con : createdContacts) {
            System.assert(con.LastName.startsWith('Test Account'), 'Contact LastName should start with "Test Account"');
            System.assert(accountMap.containsKey(con.AccountId), 'Contact should be linked to a test account');
        }
    }
}