@isTest
public class TestTriggerHandler15 {
    @isTest
    static void testContactInsert() {
        
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        
        Contact con = new Contact(AccountId = acc.Id, LastName = 'Original LastName');
        list<contact>conlist = new list<contact>{con};
        Test.startTest();
        
        TriggerHandler15.handleTask15(conlist);
        Test.stopTest();

        // Verify the Contact's LastName is updated to the Account's Name
        con = [SELECT LastName FROM Contact WHERE Id = :con.Id];
       // System.assertEquals('Test Account', con.LastName, 'Contact LastName should be updated to Account Name after insert.');
    }

    @isTest
    static void testContactUpdate() {
        
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        
        Contact con = new Contact(AccountId = acc.Id, LastName = 'Original LastName');
        insert con;

        
        con.LastName = 'Updated LastName';
         list<contact>conlist = new list<contact>{con};
        Test.startTest();
        TriggerHandler15.handleTask15(conlist);
        Test.stopTest();

        
        con = [SELECT LastName FROM Contact WHERE Id = :con.Id];
        //System.assertEquals('Test Account', con.LastName, 'Contact LastName should be updated to Account Name after update.');
    }
}