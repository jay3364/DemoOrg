@isTest
public class TestBatchTask1 {
    @isTest
    static void testBatchTask1() {
        // Create test data: Account and related Opportunity
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity',
            AccountId = acc.Id,
            StageName = 'Prospecting', 
            CloseDate = Date.today()
        );
        insert opp;

        // Instantiate the Batch class
        BatchTask1 batchJob = new BatchTask1();

        Test.startTest();
        // Start the batch job
        Id batchInstanceId = Database.executeBatch(batchJob);
        Test.stopTest();

        // Verify that the batch job completed successfully
        System.assert([SELECT Id, Status, NumberOfErrors FROM AsyncApexJob WHERE Id = :batchInstanceId].Status == 'Completed',
                      'Batch job did not complete successfully');

        // Verify that the Account was updated with the Opportunity Name
        acc = [SELECT Id, Name FROM Account WHERE Id = :acc.Id];
        System.assertEquals('Test Opportunity', acc.Name, 'Account Name should be updated with Opportunity Name');
    }
}