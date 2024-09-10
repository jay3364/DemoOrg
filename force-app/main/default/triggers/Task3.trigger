trigger Task3 on Opportunity (after update) {
    //Write a trigger on opportunity that will set the stage name to “prospecting” and the
    //close date to 15 days from today, Whenever the opportunity is modified.
    
    if(Trigger.isAfter && Trigger.isUpdate){
        TriggerHandler3.oppModification(Trigger.new);
       // TriggerHandler3.oppModification(opplist);
       /* List<Opportunity> UpdateOpp = new List<Opportunity>();
        List<Opportunity> opList =[select Id,Name,StageName,CloseDate from Opportunity];
        
        for(Opportunity opp : opList){
            if(opp.StageName != 'Prospecting' || opp.CloseDate !=Date.TODAY().addDays(15)){
            opp.StageName = 'Prospecting';
            opp.CloseDate = Date.TODAY().addDays(15);
            
            UpdateOpp.add(opp);
            }
        }
        if(!UpdateOpp.isEmpty()){
            update UpdateOpp;
        }*/
    }
}