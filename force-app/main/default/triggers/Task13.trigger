trigger Task13 on Account (after update) {
//When the rating of an account is modified to Hot, share the record with Wilson using apex-based sharing rules.
    
    if(Trigger.isAfter && Trigger.isUpdate){
        TriggerHandler13.triggerHandler(Trigger.new);
       /* set<id> accId = new set<id>();
        for(Account acc :Trigger.new){
            Account oldAcc = Trigger.Oldmap.get(acc.id);
            if(acc.Rating == 'Hot' && oldacc.Rating != 'Hot' ){
                accId.add(acc.id);
            }
        }
        if(!accId.isEmpty()){
            shareRe(accId);
            System.debug('sharing done.....');
        }
    }
    public static void shareRe(set<Id>accountId){
        List<AccountShare>accsharelist = new List<AccountShare>();
        id userId = '005dL000001CGHSQA4';
        for(id accid :accountId ){
        AccountShare accshare = new AccountShare();
        accshare.AccountId = accid;
        accshare.AccountAccessLevel = 'Edit';
        accshare.UserOrGroupId = userId;
        accshare.OpportunityAccessLevel = 'Edit';
        //accshare.RowCause = Scema.acc share.RowCause.Manual;
        
        accsharelist.add(accshare);
        }
        
        if(!accsharelist.isEmpty()){
            Database.saveResult[] rs = Database.Insert(accsharelist, false);
            for(Database.saveResult result : rs){
                if(!result.isSuccess()){
                    for(Database.error error :result.getErrors()){
                        System.debug('Failed to share account: ' + error.getMessage());
                    }
                }
            }
        }*/
    }
    
}