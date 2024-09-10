@isTest
public class TestTrigger9 {
    
    @testSetup
    static void setupTestData() {
        // Create test data for Accounts
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 5; i++) {
            accounts.add(new Account(Name = 'Test Account ' + i));
        }
        insert accounts;
    }

    @isTest
    static void testApprovalProcess() {
        // Fetch test accounts
        List<Account> testAccounts = [SELECT Id FROM Account];
        
        // Ensure we have test data
        System.assertNotEquals(0, testAccounts.size(), 'Test accounts should be created in @testSetup');

        // Call the method to test
        Test.startTest();
       // TriggerHandler9.approvalprocess(testAccounts);
        Test.stopTest();

        // Verify the process submission
        List<ProcessInstance> processInstances = [SELECT Id, Status, TargetObjectId FROM ProcessInstance WHERE TargetObjectId IN :testAccounts];
        System.assertEquals(testAccounts.size(), processInstances.size(), 'Each account should have a process instance created.');

        for (ProcessInstance instance : processInstances) {
            System.assertEquals('Pending', instance.Status, 'Process instance should be in Pending status.');
        }
    }

    @isTest
    static void testApprovalProcessWhenAlreadyInProcess() {
        // Fetch test accounts
        List<Account> testAccounts = [SELECT Id FROM Account];
        
        // Ensure we have test data
        System.assertNotEquals(0, testAccounts.size(), 'Test accounts should be created in @testSetup');

        // Submit the first account for approval to simulate it already being in an approval process
        Test.startTest();
        List<Account> singleAccount = new List<Account>{ testAccounts[0] };
        //TriggerHandler9.approvalprocess(singleAccount);
        Test.stopTest();

        // Verify the first account is in an approval process
        List<ProcessInstance> initialProcessInstances = [SELECT Id, Status, TargetObjectId FROM ProcessInstance WHERE TargetObjectId = :singleAccount[0].Id];
        System.assertEquals(1, initialProcessInstances.size(), 'The first account should have one process instance created.');
        System.assertEquals('Pending', initialProcessInstances[0].Status, 'The process instance should be in Pending status.');

        // Attempt to submit the same account for approval again
        Test.startTest();
        TriggerHandler9.approvalprocess(singleAccount);
        Test.stopTest();

        // Verify no new process instance was created for the first account
        List<ProcessInstance> finalProcessInstances = [SELECT Id, Status, TargetObjectId FROM ProcessInstance WHERE TargetObjectId = :singleAccount[0].Id];
        System.assertEquals(1, finalProcessInstances.size(), 'The first account should still have only one process instance.');
    }
}