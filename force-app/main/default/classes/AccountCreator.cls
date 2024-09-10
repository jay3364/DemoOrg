public class AccountCreator {
    public static void createAccounts() {
        List<Account> accounts = new List<Account>();
        
        for (Integer i = 0; i < 2000; i++) {
            Account acc = new Account(Name = 'Account ' + i);
            accounts.add(acc);
            
            // Insert records in batches of 50 to avoid DML limits
            if (accounts.size() == 50) {
                insertAccounts(accounts);
                accounts.clear();
            }
        }
        
        // Insert any remaining records
        if (!accounts.isEmpty()) {
            insertAccounts(accounts);
        }
    }
    
    private static void insertAccounts(List<Account> accounts) {
        Database.SaveResult[] results = Database.insert(accounts, false);
        for (Database.SaveResult result : results) {
            if (!result.isSuccess()) {
                for (Database.Error error : result.getErrors()) {
                    System.debug('Error: ' + error.getMessage());
                }
            }
        }
    }
}