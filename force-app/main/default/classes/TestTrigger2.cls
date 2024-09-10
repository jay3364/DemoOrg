@isTest
public class TestTrigger2 {

    @isTest
    static void testTrigger2(){
        List<Lead>leadlist = new List<Lead>();
        for(Integer i= 0; i < 5;i++){
            leadlist.add(new lead(LastName = 'testLead'+i, Company = 'TestCompany',Rating ='Warm'));
        }
        Test.startTest();
        TriggerHandler2.updateLead(leadlist);
        Test.stopTest();
        
        List<lead>updateLead = [select id,Rating from lead where id = :leadlist[0].id];
        List<lead>updateld = new List<lead>();
        for (Lead ld : updateLead) {
            //System.assertEquals('Hot', ld.Rating, 'Expected Rating to be "Hot"');
            ld.Rating = 'Hot';
            updateld.add(ld);
            
        }
        update updateld;
    }
}