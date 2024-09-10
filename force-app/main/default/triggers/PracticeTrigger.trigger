trigger PracticeTrigger on contact (Before insert) {
    List<Account> acclist = new List<Account>();
    Map<Id,Account> contoacc = new Map<Id,Account>();
       for(Contact con :Trigger.new){
            if(con.AccountId == null){
                Account acc = new Account();
                acc.Name  = con.LastName;
                acclist.add(acc);
                contoacc.put(con.Id,acc);
            }
       }
       System.debug(contoacc);
       if(!acclist.isEmpty()){
            insert acclist;
            System.debug('acclist=>'+acclist);
       }
    
       List<Contact> conupdate = new List<Contact>();
       for(Contact con :Trigger.new){
           if(contoacc.containsKey(con.Id)){
            Account acc = contoacc.get(con.Id);
            con.AccountId = acc.Id;
            conupdate.add(con);
           }
       }
       System.debug(conupdate);
      
    }