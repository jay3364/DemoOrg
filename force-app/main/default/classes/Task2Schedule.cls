public class Task2Schedule implements Schedulable {
    public void execute(SchedulableContext sc){
		List<Account> accListUp = new List<Account>();
        for(Account acc : [Select Id,Name,Rating from Account where Rating !='Warm']){
            acc.Rating = 'Warm';
            accListUp.add(acc);
        }
        update accListUp;
    }
    
    public void ScheduleJob(){
        String cron_Expression = '0 55 14 ? * 2,5 *'; //Seconds Minutes Hours Day_of_Month Month Day_of_Week Year
        System.Schedule('job for Update Rattig',cron_Expression,new Task2Schedule());
        //System.schedule(String jobName, String cronExpression, Schedulable classInstance);

    }
}