@isTest
public class testTrigger5 {
    @testSetup
    static void setup() {
        
        Account acc1 = new Account(Name = 'Test Account 1');
        Account acc2 = new Account(Name = 'Test Account 2');
        insert new List<Account>{acc1, acc2};

        Contact con1 = new Contact(FirstName = 'John', LastName = 'wick', Email = 'john.wick@example.com', AccountId = acc1.Id);
        Contact con2 = new Contact(FirstName = 'jonarthan', LastName = 'wick', Email = 'jane.wick@example.com', AccountId = acc2.Id);
        insert new List<Contact>{con1, con2};
    }
    
    @isTest
    static void sendNotification(){
        
    	Account acc1 = [SELECT Id, Name FROM Account WHERE Name = 'Test Account 1' LIMIT 1];
        Account acc2 = [SELECT Id, Name FROM Account WHERE Name = 'Test Account 2' LIMIT 1];

        Test.startTest();

        acc1.Name = 'Updated Account 1';
        acc2.Name = 'Updated Account 2';
        update new List<Account>{acc1, acc2};

        Test.stopTest();
        
        List<EmailMessage> emails = [SELECT Id FROM EmailMessage];
        System.assert(emails.size() > 0, 'Email messages should have been sent.');
    }
}