public class TriggerHandler11 {
    public static void triggerHandle(List<Contact>conlist){
        List<Event> eventCreate = new List<Event>();
    //if(trigger.isAfter && trigger.isInsert){
        for(Contact con :conlist){
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
        }
    //}
    }
}