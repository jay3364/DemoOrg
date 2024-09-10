@isTest
public class TestTrigger3 {
    @testSetup
    static void setUp(){
        List<Opportunity>insrtOpp = new List<Opportunity>();
        for(Integer i=0; i < 5; i++){
            Opportunity opp = new Opportunity();
            opp.Name = 'testclass3 '+i;
            opp.StageName = 'Qualification';
            opp.CloseDate = date.today().addDays(30);
            insrtOpp.add(opp);
        }
        insert insrtOpp;
        
    }
    
    @isTest
    static void testModification(){
        List<Opportunity>opplist = [select Id,Name, StageName, CloseDate from Opportunity];
        Test.startTest();
        TriggerHandler3.oppModification(opplist);
        Test.stopTest();
        List<Opportunity>updateOpp = [SELECT Id, StageName, CloseDate FROM Opportunity];
        
        for (Opportunity opp : updateOpp) {
            System.assertEquals('Prospecting', opp.StageName, 'StageName should be "Prospecting"');
            System.assertEquals(Date.today().addDays(15), opp.CloseDate, 'CloseDate should be 15 days from today');
        }
    }
}