@isTest
public class TestTask7Aura {
    @isTest
    static void testGetAccountData() {
        
        Account acc1 = new Account(Name = 'Test Account 1');
        Account acc2 = new Account(Name = 'Test Account 2');
        insert new List<Account>{ acc1, acc2 };

        Opportunity opp1 = new Opportunity(Name = 'Test Opportunity 1', AccountId = acc1.Id, CloseDate = System.today().addDays(10), StageName = 'Prospecting');
        Opportunity opp2 = new Opportunity(Name = 'Test Opportunity 2', AccountId = acc1.Id, CloseDate = System.today().addDays(15), StageName = 'Qualification');
        Opportunity opp3 = new Opportunity(Name = 'Test Opportunity 3', AccountId = acc2.Id, CloseDate = System.today().addDays(20), StageName = 'Negotiation');
        insert new List<Opportunity>{ opp1, opp2, opp3 };

        Contact con1 = new Contact(FirstName = 'John', LastName = 'Doe', AccountId = acc1.Id);
        Contact con2 = new Contact(FirstName = 'Jane', LastName = 'Smith', AccountId = acc2.Id);
        insert new List<Contact>{ con1, con2 };

        Test.startTest();
        List<Task7AuraWrapper.AccountWrapper> results = Task7AuraWrapper.getAccountData();
        Test.stopTest();

        
        System.assertNotEquals(null, results, 'Results should not be null');
        System.assertEquals(2, results.size(), 'There should be 2 AccountWrapper objects in the results');

        
        Task7AuraWrapper.AccountWrapper wrapper1 = results.get(0);
        System.assertNotEquals(null, wrapper1.account, 'Account should not be null');
        System.assertEquals('Test Account 1', wrapper1.account.Name, 'Account Name should match');

        List<Opportunity> opps1 = wrapper1.opportunities;
        System.assertEquals(2, opps1.size(), 'There should be 2 opportunities for the first account');
        
        Boolean opp1Found = false;
        Boolean opp2Found = false;
        for (Opportunity opp : opps1) {
            if (opp.Name == 'Test Opportunity 1') {
                opp1Found = true;
            }
            if (opp.Name == 'Test Opportunity 2') {
                opp2Found = true;
            }
        }
        System.assert(opp1Found, 'Opportunity 1 should be present');
        System.assert(opp2Found, 'Opportunity 2 should be present');

        List<Contact> cons1 = wrapper1.contacts;
        System.assertEquals(1, cons1.size(), 'There should be 1 contact for the first account');
        
        Boolean con1Found = false;
        for (Contact con : cons1) {
            if (con.LastName == 'John') {
                con1Found = true;
            }
        }
        System.assert(con1Found, 'Contact John should be present');

        
        Task7AuraWrapper.AccountWrapper wrapper2 = results.get(1);
        System.assertNotEquals(null, wrapper2.account, 'Account should not be null');
        System.assertEquals('Test Account 2', wrapper2.account.Name, 'Account Name should match');

        List<Opportunity> opps2 = wrapper2.opportunities;
        System.assertEquals(1, opps2.size(), 'There should be 1 opportunity for the second account');
        
        Boolean opp3Found = false;
        for (Opportunity opp : opps2) {
            if (opp.Name == 'Test Opportunity 3') {
                opp3Found = true;
            }
        }
        System.assert(opp3Found, 'Opportunity 3 should be present');

        List<Contact> cons2 = wrapper2.contacts;
        System.assertEquals(1, cons2.size(), 'There should be 1 contact for the second account');
        
        Boolean con2Found = false;
        for (Contact con : cons2) {
            if (con.FirstName == 'Jane') {
                con2Found = true;
            }
        }
        System.assert(con2Found, 'Contact Jane should be present');
    }
}