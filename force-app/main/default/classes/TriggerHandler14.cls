public class TriggerHandler14 {

     public static void handleTask14(List<Contact> newContacts, Map<Id, Contact> oldMap, Set<Id> accountIds) {
        Set<Id> idsToUpdate = new Set<Id>();
        
        //if (Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete) {
         if(!newContacts.isEmpty()){
            for (Contact con : newContacts) {
                idsToUpdate.add(con.AccountId);
            }
         }
       // }
        
        //if (Trigger.isDelete) {
        if(!newContacts.isEmpty()){
            for (Contact con : oldMap.values()) {
                idsToUpdate.add(con.AccountId);
            }
        }
        //}
        
        List<Account> accountsToUpdate = new List<Account>();
        
        for (Account acc : [SELECT Id, Name, (SELECT Id, Name, AccountId, Amount__c FROM Contacts) FROM Account WHERE Id IN :idsToUpdate]) {
            Decimal totalAmount = 0;
            
            for (Contact con : acc.Contacts) {
                totalAmount += con.Amount__c != null ? con.Amount__c : 0; 
            }
            
            acc.Total_Amount__c = totalAmount;
            accountsToUpdate.add(acc);
        }
        
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
}
}