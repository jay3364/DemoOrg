trigger Task6 on Opportunity (after update) {
    TriggerHandler6.OpportunityModification(Trigger.oldMap, Trigger.new);
}

	//Write a trigger so that whenever an opportunity name is modified, create a task for the owner of the record.
	/*set<id>AccId = new set<id>();
    List<Task>tsUpdate = new List<Task>();
    for(Opportunity opp :Trigger.new){
        if(opp.Name != Trigger.oldmap.get(opp.Id).Name){
           Task ts  = new Task(
              Subject ='TestTrigger',
              Status = 'Deferred',
              OwnerId = opp.OwnerId,
              Priority = 'Low',
              WhatId = opp.Id
           );
            tsUpdate.add(ts);     
        }
        
    }
    
    if(!tsUpdate.isEmpty()){
        insert tsUpdate;
    }*/