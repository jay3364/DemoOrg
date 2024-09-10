trigger Task7 on Account (after insert) {
    //Write a trigger to prefix the account name with Mr., or Mrs. whenever a new record is inserted.
   
    TriggerHandler7 handler = new TriggerHandler7();
    handler.AccountName(Trigger.new);
}

    /*List<Account>accList = new List<Account>();
    if(Trigger.isAfter && Trigger.isInsert){
        for(Account acc : Trigger.new){
             Account accToUpdate = new Account(
                Id = acc.Id,
                Name = (Math.random() < 0.5 ? 'Mr.' : 'Mrs.') + acc.Name
            );
            
            accList.add(accToUpdate);
        }
    }
    if(!accList.isEmpty()){
        update accList;
    }*/