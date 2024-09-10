public class OpportunityController {
	private final opportunity opp;
    
    public OpportunityController(ApexPages.StandardController stdController) {
        this.opp = (Opportunity) stdController.getRecord();
    }

     public PageReference addRandomImage() {
        FutureWebServices.apicalling(opp.Id);
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Random image is being attached. Please refresh the page after some time.'));
        
        return null;
    }
}