public class TriggerHandler6 {
    private static Boolean isExecuting = false;

    public static void OpportunityModification(Map<Id, Opportunity> oldMap, List<Opportunity> newList) {
        if (isExecuting) {
            return;
        }
        isExecuting = true;

        try {
            List<Task> tsUpdate = new List<Task>();

            for (Opportunity opp : newList) {
                Opportunity oldOpp = oldMap.get(opp.Id);
                if (oldOpp != null && !opp.Name.equals(oldOpp.Name)) {
                    Task ts = new Task(
                        Subject = 'TestTrigger',
                        Status = 'Deferred',
                        OwnerId = opp.OwnerId,
                        Priority = 'Low',
                        WhatId = opp.Id
                    );
                    tsUpdate.add(ts);
                }
            }

            if (!tsUpdate.isEmpty()) {
                insert tsUpdate;
            }
        } catch (Exception e) {
            System.debug('Exception in OpportunityModification: ' + e.getMessage());
        } finally {
            isExecuting = false;
        }
    }
}