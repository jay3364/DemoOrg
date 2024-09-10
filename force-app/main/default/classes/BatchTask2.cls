global class BatchTask2 Implements Database.Batchable<SObject>, Schedulable {
    // Create a batch class that will run every day at 9 AM and update all account description fields to the current date and time.

    global Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'SELECT Id, Name, Description FROM Account';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext bc, List<Account> scope) {
        for (Account acc : scope) {
            acc.Description = 'Update ' + DateTime.now().format('yyyy-MM-dd HH:mm:ss');
        }
        update scope;
    }

    global void finish(Database.BatchableContext bc) {
        System.debug('Batch job finished');
    }

    global void execute(SchedulableContext sc) {
        
        Database.executeBatch(new BatchTask2());
    }

    public static void scheduleBatch() {
        // Schedule the batch job to run every day at 9 AM
        String cronExp = '0 0 9 * * ?';
        System.schedule('DailyUpdateAccountDescriptionBatch', cronExp, new BatchTask2());
    }
}