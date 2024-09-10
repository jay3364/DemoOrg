trigger Task4 on Opportunity (after insert, after update) {
    
    if (Trigger.isAfter && Trigger.isInsert) {

        TriggerHandler4.typeUpdate(Trigger.new);
        /*List<Opportunity> oppInsert = new List<Opportunity>();
        for (Opportunity opp : Trigger.new) {
            
            if (opp.Type != 'New Customer') {
//read only field so we need to create instance by object
                Opportunity updatedOpp = new Opportunity(
                    Id = opp.Id,
                    Type = 'New Customer'
                );
                oppInsert.add(updatedOpp);
            }
        }
        if (!oppInsert.isEmpty()) {
            update oppInsert;
        }
    }

    // Handle After Update
    if (Trigger.isAfter && Trigger.isUpdate) {
        List<Opportunity> oppUpdate = new List<Opportunity>();
        for (Opportunity opp : Trigger.new) {
           
            if (opp.Type != 'New Customer') {
                Opportunity updatedOpp = new Opportunity(
                    Id = opp.Id,
                    Type = 'New Customer'
                );
                oppUpdate.add(updatedOpp);
            }
        }
        if (!oppUpdate.isEmpty()) {
            update oppUpdate;
        }
    }*/
}
}