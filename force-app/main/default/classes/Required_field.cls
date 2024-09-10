public without sharing class Required_field {
   @AuraEnabled(cacheable=true)
    public static List<String> getRequiredFields(String objectName) {
        List<String> requiredFields = new List<String>();
        System.debug('this is use o');
        System.debug(Schema.getGlobalDescribe());
        System.debug('==============================');
        Schema.SObjectType sObjectType = Schema.getGlobalDescribe().get(objectName);
        if (sObjectType == null) {
            
            throw new IllegalArgumentException('Invalid object name: ' + objectName);
        }
        
        
        Map<String, Schema.SObjectField> fieldsMap = sObjectType.getDescribe().fields.getMap();
        
        for (Schema.SObjectField field : fieldsMap.values()) {
            Schema.DescribeFieldResult fieldDescribe = field.getDescribe();
            
            
            if (fieldDescribe.isNillable() == false && fieldDescribe.isCreateable()) {
                requiredFields.add(fieldDescribe.getName());
            }
        }
       // System.debug(Schema.SObjectField);
        System.debug(requiredFields);
        return requiredFields;
    }
}