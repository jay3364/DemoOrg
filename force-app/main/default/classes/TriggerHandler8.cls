public class TriggerHandler8 {

    public static void Accountdelete(list<contact> conlist){
        Set<Id> accountIdsToDelete = new Set<Id>();
        System.debug('starting =');
        System.debug('conlist'+conlist);
        for (Contact con : conlist) {
            if (con.AccountId != null) {
                accountIdsToDelete.add(con.AccountId);
            }
        }

        if (accountIdsToDelete.isEmpty()) {
            return;
        }

        // Query to find accounts with remaining associated contacts
        //List<Account> accountsWithOtherContacts = [
         //   SELECT Id FROM Account WHERE Id IN :accountIdsToDelete AND 
        //    (SELECT COUNT() FROM Contact WHERE AccountId = Account.Id) > 1
        //];

        // Set to hold AccountIds that should not be deleted
        Set<Id> accountsToKeep = new Set<Id>();
        //for (Account acc : accountsWithOtherContacts) {
        //    accountsToKeep.add(acc.Id);
        //}

        
        //accountIdsToDelete.removeAll(accountsToKeep);

        // If there are accounts to delete, perform the delete operation
        if (!accountIdsToDelete.isEmpty()) {
            List<Account> accountsToDelete = [SELECT Id FROM Account WHERE Id IN :accountIdsToDelete];
            System.debug('accountsToDelete'+accountsToDelete);
            delete accountsToDelete;
        }
    }
}