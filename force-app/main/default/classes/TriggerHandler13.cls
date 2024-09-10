public class TriggerHandler13 {
    public static void triggerHandler(List<Account> accList) {
        Set<Id> accId = new Set<Id>();
        for (Account acc : accList) {
            Account oldAcc = (Account)Trigger.oldMap.get(acc.Id);
            if (acc.Rating == 'Hot' && oldAcc.Rating != 'Hot') {
                accId.add(acc.Id);
            }
        }
        if (!accId.isEmpty()) {
            shareRe(accId);
            System.debug('sharing done.....');
        }
    }

    public static void shareRe(Set<Id> accountId) {
        List<AccountShare> accShareList = new List<AccountShare>();
        Id userId = [SELECT Id FROM User WHERE Alias = 'testusr' LIMIT 1].Id;
        for (Id accId : accountId) {
            AccountShare accShare = new AccountShare();
            accShare.AccountId = accId;
            accShare.AccountAccessLevel = 'Edit';
            accShare.UserOrGroupId = userId;
            accShare.OpportunityAccessLevel = 'Edit';
            // accShare.RowCause = Schema.AccountShare.RowCause.Manual; // Uncomment if using manual sharing
            accShareList.add(accShare);
        }
        if (!accShareList.isEmpty()) {
            Database.SaveResult[] rs = Database.insert(accShareList, false);
            for (Database.SaveResult result : rs) {
                if (!result.isSuccess()) {
                    for (Database.Error error : result.getErrors()) {
                        System.debug('Failed to share account: ' + error.getMessage());
                    }
                }
            }
        }
    }
}