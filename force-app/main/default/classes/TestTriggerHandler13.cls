@isTest
public class TestTriggerHandler13 {
    @isTest
    static void testAccountSharingOnRatingChange() {
       
        String uniqueUsername = 'testuser' + DateTime.now().getTime() + '@example.com';

  
        Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        UserRole role = [SELECT Id FROM UserRole WHERE Name = 'CEO' LIMIT 1]; 
        User testUser;
        
        
        testUser = new User(
            Alias = 'testusr',
            Email = 'testuser@example.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'Testing',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            ProfileId = p.Id,
            TimeZoneSidKey = 'America/Los_Angeles',
            UserName = uniqueUsername,
            UserRoleId = role.Id 
        );
        
        insert testUser;

        testUser = [SELECT Id FROM User WHERE UserName = :uniqueUsername LIMIT 1];

        Test.startTest();
  
        System.runAs(testUser) {
            Account acc = new Account(Name = 'Test Account', Rating = 'Cold', OwnerId = testUser.Id); // Ensure ownership
            insert acc;

            acc.Rating = 'Hot';
            update acc;

           
            List<AccountShare> accShares = [SELECT Id, AccountId, UserOrGroupId, AccountAccessLevel, OpportunityAccessLevel 
                                            FROM AccountShare 
                                            WHERE AccountId = :acc.Id 
                                            AND UserOrGroupId = :testUser.Id];

            System.assertEquals(1, accShares.size(), 'One account share should have been created.');
            //System.assertEquals('Edit', accShares[0].AccountAccessLevel, 'Account access level should be Edit.');
            //System.assertEquals('Edit', accShares[0].OpportunityAccessLevel, 'Opportunity access level should be Edit.');
        }
        
        Test.stopTest();
    }
}