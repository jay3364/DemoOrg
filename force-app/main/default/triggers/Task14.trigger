trigger Task14 on Contact (After insert,after update , After delete,After undelete) {
    
    TriggerHandler14.handleTask14(
        Trigger.isDelete ? null : Trigger.new,
        Trigger.isInsert ? null : Trigger.oldMap,
        Trigger.isDelete ? Trigger.oldMap.keySet() : Trigger.newMap.keySet()
    );

//Write a trigger so that whenever values are added/modified to the “Amount” field in Contact, It should update “Total Amount” to its associated parent Account
    set<Id> ids = new set<id>();
    for (Contact con : trigger.new) {
            ids.add(con.AccountId);
    }

    if(Ids != null && Contact.Amount__c !=null){
        for(Account acc : [select Name,Total_Amount__c ,(select Name,Amount__c from Contacts) from Account where Id IN :Ids]){
            for(Contact con : acc.Contacts){
                acc.Total_Amount__c = con.Amount__c;
                System.debug('i am debug'+con.Amount__c);
            }
        }
    } 
                    
    
    }            
           /* for(Contact con : Trigger.new){
                ids.add(con.AccountId);
            }
        }
        if(Trigger.isDelete){
            for(Contact con :Trigger.new){
                ids.add(con.AccountId);
            }
        }
            
        List<Account>accUpdate = new List<Account>();
        for(Account acc : [select Id,Name, (select id,Name,AccountId, Amount__c  from Contacts) from Account where Id IN :Ids]){
           Decimal totalAmount = 0;
            for(contact con :acc.Contacts){
                totalAmount+= con.Amount__c!=null ? con.Amount__c:0; 
                
            }
            acc.Total_Amount__c = totalAmount;
            accUpdate.add(acc);
        }
        if(!accUpdate.isEmpty()){
            update accUpdate;
        }*/