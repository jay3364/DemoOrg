trigger Task9 on Account (after insert) {
    //TriggerHandler9 TH9 = new TriggerHandler9();
    TriggerHandler9.approvalprocess(Trigger.new); 
    /*
    List<Id> accountIdsToSubmit = new List<Id>();
    
    for(Account acc : Trigger.new) {
        accountIdsToSubmit.add(acc.Id);
    }

   
    if (!accountIdsToSubmit.isEmpty()) {
       
        List<Approval.ProcessSubmitRequest> approvalRequests = new List<Approval.ProcessSubmitRequest>();
        
       
        for (Id accountId : accountIdsToSubmit) {
            Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
            req.setComments('Submitted for approval. Please approve.');
            req.setObjectId(accountId);
            // Optionally, set the next approver IDs
            req.setNextApproverIds(new Id[] { UserInfo.getUserId() }); // Example: Specify approver user IDs
            //req.setProcessDefinitionNameOrId('TriggerAccout');
            // req.setSubmitterId(UserInfo.getUserId());
            Approval.ProcessResult approvalResults = Approval.process(req);
            //approvalRequests.add(req);
        }
        
        System.debug('approvalRequests===>'+approvalRequests);
        
        /*try {
            List<Approval.ProcessResult> approvalResults = Approval.process(approvalRequests);
            
            
            for (Approval.ProcessResult result : approvalResults) {
                if (result.isSuccess()) {
                    System.debug('Submitted for approval successfully: ' + result.getInstanceId());
                } else {
                    System.debug('Failed to submit for approval: ' + result.getErrors());
                }
            }
        } catch (Exception e) {
            
            System.debug('Exception occurred during approval submission: ' + e.getMessage());
        }
    }*/
}