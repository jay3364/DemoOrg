@isTest
public class TestTrigger12 {

    @isTest
    static void testDuplicateAccountDeletion() {
        Account acc1 = new Account(Name = 'Test Account');
        insert acc1;
 
        List<Account> insertedAccounts = [SELECT Id, Name FROM Account WHERE Name = 'Test Account'];
        System.assertEquals(1, insertedAccounts.size(), 'One account should have been inserted initially.');

        Account acc2 = new Account(Name = 'Test Account');

        Test.startTest();
        insert acc2;
        Test.stopTest();

        List<Account> remainingAccounts = [SELECT Id, Name FROM Account WHERE Name = 'Test Account'];
        System.assertEquals(1, remainingAccounts.size(), 'Only one account should remain after insertion.');
        System.assertEquals(acc2.Id, remainingAccounts[0].Id, 'The remaining account should be the new one.');
    }
}