public class Task13Trigger {
	
        
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
            }
        }
}