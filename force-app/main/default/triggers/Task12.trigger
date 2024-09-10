trigger Task12 on Account (before insert) {
//Write a trigger so that whenever a new record is created into an Account object 
//before this new record is inserted delete the accounts with the same name.
    Map<String,List<Account>> AccountMapName = new Map<String,list<Account>>();
    if(Trigger.isBefore && Trigger.isInsert){
        TriggerHandler12.triggerHandler(Trigger.new);
          }
}
       /* for(Account acc :Trigger.new){
            if(AccountMapName.containsKey(acc.Name)){
                AccountMapName.get(acc.Name).add(acc);
            }
            else{
                AccountMapName.put(acc.Name,new List<Account>{acc});
            }
    }        
        List<Account>deleteAccount = new List<Account>();
        for(String AccName :AccountMapName.keySet()){
            List<Account>existingAcc = [select id,Name from Account where Name= :AccName];
            
            if(!existingAcc.isEmpty()){
                deleteAccount.addAll(existingAcc);
            }
        }
        
        if(!deleteAccount.isEmpty()){
        delete deleteAccount;
        }*/
  
/* to store unique Name create map lof accc list
check by map that new record has same name then store in list of map of acc
else name has unique then it store in map with new name

now delete record
get unique named account from map and make list of existing account
then delete all the existing record by list  */