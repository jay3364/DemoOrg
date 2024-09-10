public class TriggerHandler7 {
    public void AccountName(List<Account>accList){
          
   for(Account acc : accList){
        Account accToUpdate = new Account(
            Id = acc.Id,
            Name = (Math.random() < 0.5 ? 'Mr.' : 'Mrs.') + acc.Name
        );
    
    accList.add(accToUpdate); 
}

    
    if(!accList.isEmpty()){
        update accList;
    }
    }
}