public class ExceptionHandling {
    Public  static void CreateException(Exception e, String className, String methodName, String moreDetails){
        Error_log__c el = new Error_log__c();
        el.Class_Name__c = className;
        el.Method_Name__c = methodName;
        el.More_Details__c = moreDetails;
        el.Exception_Type__c = e.getTypeName();
        el.Line_Number__c = e.getLineNumber();
        
         try {
            insert el;
        } catch (DmlException dmlEx) {
            // Handle any exception that occurs while logging the error
            System.debug('Failed to create error log: ' + dmlEx.getMessage());
        }
    }
}