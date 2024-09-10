@isTest
public class TestEsceptionHandling {
    @isTest
    static void testCreateException() {
        
        try {
            Integer a = 1/0; 
        } catch (Exception e) {
            
            ExceptionHandling.CreateException(e, 'TestExceptionHandling', 'testCreateException', 'Dividing by zero');
        }

        List<Error_log__c> errorLogs = [SELECT Id, Class_Name__c, Method_Name__c, More_Details__c, Exception_Type__c, Line_Number__c 
                                        FROM Error_log__c WHERE Class_Name__c = 'TestExceptionHandling' AND Method_Name__c = 'testCreateException'];
        System.assertEquals(1, errorLogs.size(), 'Error log should have been created');
        Error_log__c errorLog = errorLogs[0];
        System.assertEquals('TestExceptionHandling', errorLog.Class_Name__c, 'Class name should match');
        System.assertEquals('testCreateException', errorLog.Method_Name__c, 'Method name should match');
        System.assertEquals('Dividing by zero', errorLog.More_Details__c, 'More details should match');
        System.assertEquals('System.MathException', errorLog.Exception_Type__c, 'Exception type should match');
        System.assertNotEquals(null, errorLog.Line_Number__c, 'Line number should not be null');
    }
}