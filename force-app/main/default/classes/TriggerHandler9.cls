public with sharing class TriggerHandler9 {

public static void approvalprocess(List<Account> acc){
    Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
    for(Account a : acc){
        req1.setComments('Submitting request for approval.');
        req1.setObjectId(a.id);
        req1.setNextApproverIds(new Id[] { UserInfo.getUserId() });
// Submit on behalf of a specific submitter
		req1.setSubmitterId(UserInfo.getUserId()); 
        
        // Submit the record to specific process and skip the criteria evaluation
        req1.setProcessDefinitionNameOrId('TriggerAccout');
        req1.setSkipEntryCriteria(true);
        
        Approval.ProcessResult result = Approval.process(req1);
}
}
}