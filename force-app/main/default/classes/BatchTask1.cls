global class BatchTask1 implements Database.Batchable<SObject> {
    // Create a batch class that will update the related account name with the opportunity name.

    global Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'SELECT Id, Name, AccountId FROM Opportunity WHERE AccountId != null';
        System.debug('Start method query: ' + query);
        
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext bc, List<Opportunity> scope) {
         String batchJobId = bc.getJobId();
        System.debug('Batch Job ID: ' + batchJobId);
        
        List<Account> accountsToUpdate = new List<Account>();
        
        for (Opportunity opp : scope) {
            if (opp.AccountId != null) {
                Account acc = new Account(
                    Id = opp.AccountId,
                    Name = opp.Name
                );
                accountsToUpdate.add(acc);
                System.debug('Updating Account: ' + acc.Id + ' with Opportunity Name: ' + acc.Name);
            }
        }

        if (!accountsToUpdate.isEmpty()) {
            try {
                update accountsToUpdate;
                System.debug('Accounts updated successfully.');
            } catch (Exception e) {
                ExceptionHandling.CreateException(e, 'BatchTask1', 'execute', 'moreDetails');
                System.debug('Error updating accounts: ' + e.getMessage());
            }
        }
    }

    global void finish(Database.BatchableContext bc) {
        System.debug('Batch process finished.');
        String batchJobId = bc.getJobId();
        System.debug('Batch Job finished with Job ID: ' + batchJobId);
    }
}