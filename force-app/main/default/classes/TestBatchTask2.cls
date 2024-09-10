@isTest
public class TestBatchTask2 {

    @isTest
    static void testBatchTask2() {
        // Create test data: Account records
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 5; i++) {
            Account acc = new Account(Name = 'Test Account ' + i);
            accounts.add(acc);
        }
        insert accounts;

        // Instantiate the batch class
        BatchTask2 batchJob = new BatchTask2();

        Test.startTest();
        // Start the batch job
        Id batchInstanceId = Database.executeBatch(batchJob);
        Test.stopTest();

        // Verify that the batch job completed successfully
        System.assert([SELECT Id, Status, NumberOfErrors FROM AsyncApexJob WHERE Id = :batchInstanceId].Status == 'Completed',
                      'Batch job did not complete successfully');

        // Verify that Account descriptions were updated correctly
        List<Account> updatedAccounts = [SELECT Id, Description FROM Account];
        for (Account acc : updatedAccounts) {
            String expectedDescription = 'Update ' + DateTime.now().format('yyyy-MM-dd HH:mm:ss');
            System.assertEquals(expectedDescription, acc.Description,
                                'Account Description should match current date and time');
        }
    }

    @isTest
    static void testBatchTask2Scheduling() {
        // Schedule the batch job
        Test.startTest();
        BatchTask2.scheduleBatch();
        Test.stopTest();

        // Verify that the job is scheduled correctly
        CronTrigger scheduledJob = [SELECT Id, CronExpression, NextFireTime FROM CronTrigger WHERE CronJobDetail.Name = 'DailyUpdateAccountDescriptionBatch'];
        System.assertNotEquals(null, scheduledJob, 'Job not scheduled');

        // Verify the cron expression
        System.assertEquals('0 0 9 * * ?', scheduledJob.CronExpression,
                            'Cron expression should be 0 0 9 * * ?');
    }
}