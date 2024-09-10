@isTest
public class TestSchedule1 {
    @isTest
    static void testTask1Schedule() {
        Test.startTest();

        // Schedule the job
        Task1Schedule scheduler = new Task1Schedule();
        scheduler.ScheduleJob();

        // Wait for the scheduled job to execute
        // No need to add a delay here, as the scheduled job is expected to run at the specified time

        Test.stopTest();

        // Verify the created opportunities
        List<Opportunity> opps = [SELECT Id, Name, StageName, CloseDate FROM Opportunity WHERE Name = 'Schedule1'];
        
        // Assert that 10 opportunities were created
        System.assertEquals(10, opps.size(), 'Incorrect number of opportunities created');

        // Assert Opportunity attributes
        for (Opportunity opp : opps) {
            System.assertEquals('Schedule1', opp.Name, 'Opportunity Name should be Schedule1');
            System.assertEquals('Negotiation/Review', opp.StageName, 'Opportunity StageName should be Negotiation/Review');
            System.assertEquals(Date.today(), opp.CloseDate, 'Opportunity CloseDate should be today');
        }
    }
}