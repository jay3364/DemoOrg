public class Task1Schedule implements Schedulable {
    public void execute(schedulableContext sc){      	
       List<Opportunity>oppList = new List<Opportunity>();
        for(Integer i = 0;i<10;i++){
             Opportunity opp = new Opportunity();
            opp.Name = 'Schedule1';
            opp.StageName = 'Negotiation/Review';
            opp.CloseDate = Date.Today();
            oppList.add(opp);
        }
        insert oppList;            
        }
    
    public void ScheduleJob(){
        String Cron_Exp = '0 05 15 * * ?';
        System.schedule('job for create opportunity',Cron_Exp,new Task1Schedule());
    }
    }