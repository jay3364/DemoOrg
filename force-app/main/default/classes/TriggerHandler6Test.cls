@isTest
public class TriggerHandler6Test {
    
    @testSetup
    static void setup() {
       
        Opportunity opp1 = new Opportunity(Name = 'Test Opportunity 1', StageName = 'Prospecting', CloseDate = Date.today());
        Opportunity opp2 = new Opportunity(Name = 'Test Opportunity 2', StageName = 'Prospecting', CloseDate = Date.today());
        insert new List<Opportunity>{opp1, opp2};
    }
    
    @isTest
    static void testOpportunityNameChangeCreatesTask() {
        
        Opportunity opp1 = [SELECT Id, Name FROM Opportunity WHERE Name = 'Test Opportunity 1' LIMIT 1];
        Opportunity opp2 = [SELECT Id, Name FROM Opportunity WHERE Name = 'Test Opportunity 2' LIMIT 1];
        
        
        Test.startTest();
        
        
        opp1.Name = 'Updated Opportunity 1';
        opp2.Name = 'Updated Opportunity 2';
        update new List<Opportunity>{opp1, opp2};
        
        
        Test.stopTest();
        
        
        List<Task> tasks = [SELECT Id, Subject, WhatId FROM Task WHERE Subject = 'TestTrigger'];
        System.assertEquals(2, tasks.size(), 'Two tasks should have been created.');
        System.assertEquals(opp1.Id, tasks[0].WhatId, 'The first task should be related to the first opportunity.');
        System.assertEquals(opp2.Id, tasks[1].WhatId, 'The second task should be related to the second opportunity.');
    }
}