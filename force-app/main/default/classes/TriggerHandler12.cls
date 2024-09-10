public class TriggerHandler12 {

    public static void triggerHandler(list<Account>acclist){
        Map<String, List<Account>> AccountMapName = new Map<String, List<Account>>();

        for (Account acc : accList) {
            if (AccountMapName.containsKey(acc.Name)) {
                AccountMapName.get(acc.Name).add(acc);
            } else {
                AccountMapName.put(acc.Name, new List<Account>{acc});
            }
        }

        List<Account> deleteAccount = new List<Account>();
        for (String AccName : AccountMapName.keySet()) {
            List<Account> existingAcc = [SELECT Id, Name FROM Account WHERE Name = :AccName];
            if (!existingAcc.isEmpty()) {
                deleteAccount.addAll(existingAcc);
            }
        }

        if (!deleteAccount.isEmpty()) {
            delete deleteAccount;
        }
    }
}