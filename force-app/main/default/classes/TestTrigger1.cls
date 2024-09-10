@isTest
public class TestTrigger1 {
	@isTest
    static void testBeforeInsert(){
       
        // Account acc = new Account(Name = 'Testaccount before Insert');
        // insert acc;
        List<Account> acc  = new List<Account>();
        acc.add(new Account(Name='Test 1'));
        acc.add(new Account(Name='Test 2'));
        Test.startTest();
        TriggerHandler1.beforeInsert(acc);
        Test.stopTest();
    }
    
   @isTest
    static void testBeforeUpdate() {
        
        Account acc = new Account(Name = 'Testaccount testBeforeUpdate Insert');
        insert acc;

        acc.Name = 'Update Account';

        List<Account> newRecords = new List<Account>{acc};
        System.debug('NewRecord ==>'+newRecords);
        List<Account> oldRecords = [SELECT Id, Name FROM Account WHERE Id = :acc.Id];
        System.debug('oldRecords ==>'+oldRecords);
        Map<Id, Account> newMap = new Map<Id, Account>{acc.Id => acc};
        Map<Id, Account> oldMap = new Map<Id, Account>{acc.Id => oldRecords[0]};

        
        Test.startTest();
        update acc;
        TriggerHandler1.beforeUpdate(newRecords, oldRecords, newMap, oldMap);
        Test.stopTest();
    }
    
    @isTest
    static void testBeforeDelete(){
        Account acc = new Account(Name = 'Testaccount testBeforeDelete Insert');
        insert acc;
        List<Account> oldRecords = [select Id,Name from Account where Id = :acc.Id];
        System.debug('testBeforeDelete==>'+oldRecords);
        Test.startTest();
        delete acc;
        TriggerHandler1.beforeDelete(oldRecords);
        Test.stopTest();
    }
     @isTest
    static void testAfterInsert(){
        Test.startTest();
        Account acc = new Account(Name = 'Tetsaccount testAfterInsert insert');
        insert acc;
        List<Account> newRecord = new List<Account>{acc};
        Map<id,Account> newMap = new Map<id,Account>{acc.Id=>acc};
        TriggerHandler1.afterInsert(newRecord ,newMap);
        Test.stopTest();
    }
    
     @IsTest
    static void testAfterUpdate() {
        Account acc = new Account(Name = 'Test Account After Update');
        insert acc;

        List<Account> newRecord = new List<Account>{acc};
        List<Account> oldRecords = [select id from Account where id =:acc.id];
        Map<Id, Account> newMap = new Map<Id, Account>{acc.Id=>acc};
        Map<Id, Account> oldMap = new Map<Id, Account>{acc.Id=>oldRecords[0]};


        Test.startTest();
        acc.Name = 'Updated Test Account After Update';
        update acc;
        
        TriggerHandler1.afterUpdate(newRecord,oldRecords,newMap,oldMap);
        Test.stopTest();
        
    }

    @IsTest
    static void testAfterDelete() {
        Account acc = new Account(Name = 'Test Account After Delete');
        insert acc;
        List<Account> acclist = new List<Account>{acc};
        Test.startTest();
        delete acc;
        TriggerHandler1.afterDelete(acclist);
        Test.stopTest();
        
    }

    @IsTest
    static void testAfterUndelete() {
        Account acc = new Account(Name = 'Test Account After Undelete');
        insert acc;
        delete acc;
        List<Account> acclist = new List<Account>{acc};
        Map<Id,Account> accMAP = new Map<Id,Account>{acc.id => acc};
        Test.startTest();
        
        undelete acc;
        TriggerHandler1.afterUndelete(acclist,accMAP);
        Test.stopTest();
        
    }
    
 }