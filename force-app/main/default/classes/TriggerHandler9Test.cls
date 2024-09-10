@isTest
public class TriggerHandler9Test {

    @testSetup
    static void setup() {
        
        String uniqueUserName = 'standarduser+' + DateTime.now().getTime() + '@test.com';
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User' LIMIT 1];
        if (p == null) {
            p = [SELECT Id FROM Profile LIMIT 1];
        }

        User u = new User(Alias = 'standtst', Email='standarduser@test.com',
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName=uniqueUserName);
        insert u;     
        Account acc = new Account(Name='Test Account');
        insert acc;
        System.debug('acc insert==>'+acc);
    }

    @isTest
    static void testApprovalProcess() {
       
        User u = [SELECT Id FROM User WHERE Alias = 'standtst' LIMIT 1];
        System.runAs(u) {
            
            List<Account> accounts = [SELECT Id,Name FROM Account where Name = 'Test Account'];
            System.debug('accclist==> '+accounts);
            System.assert(accounts.size() > 0, 'Test account should exist');
            Account acc = accounts[0];
            
            
            Test.startTest();
            
            List<Account> accList = new List<Account>{acc};
            TriggerHandler9.approvalprocess(accList);
            
            Test.stopTest();
            
           
            List<ProcessInstance> instances = [
                SELECT Id, Status 
                FROM ProcessInstance 
                WHERE TargetObjectId = :acc.Id
            ];
            
            System.assertEquals(1, instances.size(), 'There should be one approval process instance');
            System.assertEquals('Pending', instances[0].Status, 'The approval process instance should be pending');
        }
    }
}