public class TriggerHandler15 {
    public static Boolean isExecuting = false;

    public static void handleTask15(List<Contact> newContacts) {
        if (!TriggerHandler15.isExecuting) {
            TriggerHandler15.isExecuting = true;

            try {
                List<Contact> conUpdate = new List<Contact>();
                Map<Id, String> accountIdToNameMap = new Map<Id, String>();

                // Extract Account IDs from the newContacts list
                Set<Id> accountIds = new Set<Id>();
                for (Contact con : newContacts) {
                    if (con.AccountId != null) {
                        accountIds.add(con.AccountId);
                    }
                }

                // Query to get Account names for the related Contacts
                if (!accountIds.isEmpty()) {
                    for (Account acc : [SELECT Id, Name FROM Account WHERE Id IN :accountIds]) {
                        accountIdToNameMap.put(acc.Id, acc.Name);
                    }
                }

                // Update Contact LastName to Account Name
                for (Contact con : newContacts) {
                    if (accountIdToNameMap.containsKey(con.AccountId)) {
                        con.LastName = accountIdToNameMap.get(con.AccountId);
                        conUpdate.add(con);
                    }
                }

                // Perform update if there are Contacts to update
                if (!conUpdate.isEmpty()) {
                    update conUpdate;
                }
            } finally {
                TriggerHandler15.isExecuting = false;
            }
        }
    }
}