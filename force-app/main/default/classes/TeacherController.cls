public with sharing class TeacherController {
    @AuraEnabled(cacheable=true)
    public static List<Teacher__c> getTeacherDetails(Id teacherId) {
        return [SELECT Id, Name, Email__c FROM Teacher__c WHERE Id = :teacherId LIMIT 1];
    }

    @AuraEnabled
    public static void updateTeacher(Teacher__c teacher) {
        update teacher;
    }
}