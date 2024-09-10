trigger Task15 on Contact (after update) {
    TriggerHandler15.handleTask15(Trigger.new);
    /*public static Boolean isExecuting = false;
if (!Task15Trigger.isExecuting) {
        Task15Trigger.isExecuting = true; 
        
        List<Contact> conUpdate = new List<Contact>();
        Map<Id, String> accountIdToNameMap = new Map<Id, String>();
        
       
        for (Account acc : [SELECT Id, Name FROM Account WHERE Id IN (SELECT AccountId FROM Contact WHERE Id IN :Trigger.new)]) {
            accountIdToNameMap.put(acc.Id, acc.Name);
        }
        
       
        for (Contact con : Trigger.new) {
            if (accountIdToNameMap.containsKey(con.AccountId)) {
                Contact updatedContact = new Contact(
                    Id = con.Id,
                    LastName = accountIdToNameMap.get(con.AccountId)
                );
                conUpdate.add(updatedContact);
            }
        }

        
        if (!conUpdate.isEmpty()) {
            update conUpdate;
        }

        Task15Trigger.isExecuting = false; 
    }*/
}