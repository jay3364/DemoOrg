public class TriggerHandler2 {

    public static void  updateLead(List<lead>newlist){
	List<Lead> updateList = new List<Lead>();
        
        for (Lead ld : newlist) {
            ld.Rating = 'Hot';
            updateList.add(ld);
            System.debug('Updated lead: ' + ld);
        }
        
        if (!updateList.isEmpty()) {
            update updateList;
        }        
    }
}