public class TriggerHandler3 {

    public static void oppModification(List<Opportunity>opplist){
     List<Opportunity> UpdateOpp = new List<Opportunity>();
        //List<Opportunity> opList =[select Id,Name,StageName,CloseDate from Opportunity];
        
        for(Opportunity opp : opplist){
            if(opp.StageName != 'Prospecting' || opp.CloseDate !=Date.TODAY().addDays(15)){
            opp.StageName = 'Prospecting';
            opp.CloseDate = Date.TODAY().addDays(15);
            
			UpdateOpp.add(opp);
            }
        }
        if(!UpdateOpp.isEmpty()){
            update UpdateOpp;
        }
    }
}