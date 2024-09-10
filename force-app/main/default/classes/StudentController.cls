public with sharing class StudentController {
    @AuraEnabled(cacheable=true)
    public static List<Student__c> getStudents(Id teacherId) {
        return [SELECT Id, Name, Class__c,Teacher__c FROM Student__c WHERE Teacher__c = :teacherId];
    }

    @AuraEnabled(cacheable=true)
    public static Student__c getStudentDetails(Id studentId) {
        return [SELECT Id, Name, Class__c FROM Student__c WHERE Id = :studentId LIMIT 1];
    }

    @AuraEnabled
    public static void saveFeedback(Feedback__c feedback){
        try {
            insert feedback;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}