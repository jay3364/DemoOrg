@isTest
public class TestTrigger7 {
    @isTest
    static void testAccountName(){
        List<Account> accList = new List<Account>();
        for (Integer i = 0; i < 5; i++) {
            Account acc = new Account(
                Name = 'Test Account ' + i
            );
            accList.add(acc);
        }
        insert accList;

        
        Test.startTest();
        TriggerHandler7 handler = new TriggerHandler7();
        handler.AccountName(accList);
        Test.stopTest();

        
        List<Account> updatedAccounts = [SELECT Id, Name FROM Account WHERE Id IN :accList];
        System.assertEquals(accList.size(), updatedAccounts.size(), 'Number of accounts should remain unchanged');

        for (Account acc : updatedAccounts) {
            System.assertNotEquals(acc.Name, 'Test Account'); 
        }
    }
    }