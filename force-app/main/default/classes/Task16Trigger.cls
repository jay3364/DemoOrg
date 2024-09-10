public class Task16Trigger {
    public static void maxDivide(List<Contact>contactList){
	set<Id>Ids = new set<Id>();
        
    Map<Id,Decimal> accMaxAmount = new Map<Id,Decimal>();
        //get all contact of related Account
    for(Contact con : contactList){
        if(con.AccountId !=null){
            Ids.add(con.AccountId);
        }
    }
        System.debug('Related Account id '+Ids);
        for(Account acc :[select Id,Name, Maximum_Amount__c from Account where Id IN :Ids]){
            accMaxAmount.put(acc.Id,acc.Maximum_Amount__c);
        }
        List<Contact> newconlist = new List<contact>();
        for(contact con :contactList){
            if(con.AccountId != null && con.Amount_Count__c !=null){
                Decimal MaxAmount = accMaxAmount.get(con.AccountId); //get all related contact with maximum amount
                System.debug('MaxAmount '+MaxAmount);
                if(MaxAmount != null && con.Amount_Count__c > MaxAmount){
                    Decimal remainAmount = con.Amount_Count__c;
                    System.debug('RemainAmount='+remainAmount);
                    while(remainAmount > MaxAmount){
                        Contact newcon = con.clone();
                        newcon.Amount_Count__c = MaxAmount;
                        newconlist.add(newcon);
                        System.debug('this is in while');
                        remainAmount -= MaxAmount;
                    }
                }
            }
            if (!newconlist.isEmpty()) {
            insert newconlist;
        }
        }
        
    }
}