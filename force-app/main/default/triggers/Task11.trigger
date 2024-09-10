trigger Task11 on Contact (after insert) {
//. Whenever a new contact is created, create an event related to that contact
        List<Event> eventCreate = new List<Event>();
    if(trigger.isAfter && trigger.isInsert){
        /*for(Contact con :trigger.new){
            Event ev = new Event(
            Subject = 'Meeting with ' + con.LastName,
                StartDateTime = DateTime.now(),
                EndDateTime = DateTime.now().addDays(5),
                WhoId = con.Id
            );
            eventCreate.add(ev);
        }
        
        if(!eventCreate.isEmpty()){
            insert eventCreate;
        }*/
        TriggerHandler11.triggerHandle(trigger.new);
    }
}