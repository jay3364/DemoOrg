public class triggerHandler16 {
    public static void maxDivide(List<Contact> contactList) {
        Set<Id> accountIds = new Set<Id>();
        Map<Id, Decimal> accMaxAmount = new Map<Id, Decimal>();
        
        // Collect Account IDs from the Contact list
        for (Contact con : contactList) {
            if (con.AccountId != null) {
                accountIds.add(con.AccountId);
            }
        }
        
        // Fetch Maximum_Amount__c for each Account
        for (Account acc : [SELECT Id, Maximum_Amount__c FROM Account WHERE Id IN :accountIds]) {
            accMaxAmount.put(acc.Id, acc.Maximum_Amount__c);
        }
        
        List<Contact> newContacts = new List<Contact>();
        
        for (Contact con : contactList) {
            if (con.AccountId != null && con.Amount_Count__c != null) {
                Decimal maxAmount = accMaxAmount.get(con.AccountId);
                
                if (maxAmount != null && con.Amount_Count__c > maxAmount) {
                    Decimal remainAmount = con.Amount_Count__c;
                    
                    while (remainAmount > maxAmount) {
                        Contact newCon = con.clone();
                        newCon.Amount_Count__c = maxAmount;
                        newContacts.add(newCon);
                        remainAmount -= maxAmount;
                    }
                    
                    // If original Contact's Amount_Count__c was <= maxAmount, update it
                    if (remainAmount > 0) {
                        con.Amount_Count__c = remainAmount;
                        newContacts.add(con);
                    }
                } else {
                    newContacts.add(con); // Add the original Contact if no splitting is needed
                }
            }
        }
        
        // Perform DML operation outside the loop
        if (!newContacts.isEmpty()) {
            insert newContacts;
        }
    }
}