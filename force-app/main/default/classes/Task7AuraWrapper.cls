public with sharing class Task7AuraWrapper {
    public class AccountWrapper {
        @AuraEnabled
        public Account account { get; set; }
        @AuraEnabled
        public List<Opportunity> opportunities { get; set; }
        @AuraEnabled
        public List<Contact> contacts { get; set; }

        public AccountWrapper(Account acc, List<Opportunity> opps, List<Contact> cons) {
            this.account = acc;
            this.opportunities = opps;
            System.debug('this.opportunities: ' + this.opportunities);
            this.contacts = cons;
            System.debug('this.contacts: ' + this.contacts);
        }
    }

    @AuraEnabled
    public static List<AccountWrapper> getAccountData() {
        List<AccountWrapper> accountWrapperList = new List<AccountWrapper>();

        List<Account> accounts = [SELECT Id, Name, (SELECT Id, Name FROM Opportunities), (SELECT Id, Name FROM Contacts) FROM Account limit 20];

        for (Account acc : accounts) {
            List<Opportunity> opps = acc.Opportunities; 
            System.debug('opportunity'+opps);
            List<Contact> cons = acc.Contacts;
            System.debug('contactsList'+cons);
            AccountWrapper wrapper = new AccountWrapper(acc, opps, cons);
            accountWrapperList.add(wrapper);
            System.debug('accountWrapperList inside loop'+accountWrapperList);
        }
        System.debug('accountWrapperList'+accountWrapperList);
        return accountWrapperList;
    }
}