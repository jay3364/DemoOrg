@isTest
public class TestTrigger4 {
	@testSetup
    static void setup(){
        List<Opportunity> opplist = new List<Opportunity>();
        for(Integer i = 0 ; i < 5; i++){
            Opportunity opp = new Opportunity();
            opp.Name = 'Test Opportunity ' + i;
            opp.StageName = 'Prospecting';
            opp.CloseDate = Date.today().addDays(30);
            opp.Type = 'Existing Customer';
            
            opplist.add(opp);
        }
        insert opplist;
    }
    @isTest
    static void testTypeUpdate(){
        list<Opportunity> testlist = [select id,Name,StageName,CloseDate,Type from Opportunity];
        
        Test.startTest();
        TriggerHandler4.typeUpdate(testlist);
        Test.stopTest();
        
        List<Opportunity> updateopp = [select id,Name,StageName,CloseDate,Type from Opportunity];
        for(Opportunity opp :updateopp){
            System.assertEquals('New Customer',opp.Type,'The Type should be updated to New Customer');
        }
    }
    @isTest
    static void testTrigger(){
        List<Opportunity>listopp = [select id, StageName,Type from Opportunity];
        for(Opportunity opp : listopp){
            opp.StageName = 'Qualification';
            
        }
        
        Test.startTest();
        update listopp;
        Test.stopTest();
        
        List<Opportunity> updatedOpps = [SELECT Id, Type FROM Opportunity];
        for (Opportunity opp : updatedOpps) {
            System.assertEquals('New Customer', opp.Type, 'The Type should be updated to New Customer after trigger update');
        }
    }
}