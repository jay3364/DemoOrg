@isTest
private class TestTriggerHandler6 {

    // Test method to cover the trigger handler logic
    static testMethod void testOpportunityModification() {
        // Create test data: Opportunities
        Opportunity oldOpp = new Opportunity(
            Name = 'Old Opportunity',
            StageName = 'Prospecting',
            CloseDate = Date.today(),
            OwnerId = UserInfo.getUserId()
        );
        insert oldOpp;

        Opportunity newOpp = new Opportunity(
            Name = 'New Opportunity',
            StageName = 'Prospecting',
            CloseDate = Date.today(),
            OwnerId = UserInfo.getUserId()
        );
        insert newOpp;

        // Create a map of old opportunities (simulate oldMap parameter)
        Map<Id, Opportunity> oldMap = new Map<Id, Opportunity>{
            oldOpp.Id => oldOpp
        };

        // Create a list of new opportunities (simulate newList parameter)
        List<Opportunity> newList = new List<Opportunity>{
            newOpp
        };

        // Call the trigger handler method
        Test.startTest();
        TriggerHandler6.OpportunityModification(oldMap, newList);
       
        Test.stopTest();

        // Verify that tasks were created if conditions were met
        List<Task> createdTasks = [SELECT Id, Subject, Status, OwnerId, WhatId FROM Task];
        System.assertEquals(1, createdTasks.size(), 'Expected 1 task to be created');

        Task createdTask = createdTasks[0];
        System.assertEquals('TestTrigger', createdTask.Subject);
        System.assertEquals('Deferred', createdTask.Status);
        System.assertEquals(newOpp.OwnerId, createdTask.OwnerId);
        System.assertEquals(newOpp.Id, createdTask.WhatId);
    }

    // Additional test methods can be added to cover more scenarios
}