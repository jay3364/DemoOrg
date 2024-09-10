public  class TriggerHandler1 {
    
        public static void beforeInsert(List<Account> newRecords) {
            System.debug('Trigger is before insert ' + newRecords);
        }
        
        public static void beforeUpdate(List<Account> newRecords, List<Account> oldRecords, Map<Id, Account> newMap, Map<Id, Account> oldMap) {
            System.debug('Trigger is before update New ' + newRecords);
            System.debug('Trigger is before update Old ' + oldRecords);
            System.debug('Trigger.newMap: ' + newMap);
            System.debug('Trigger.oldMap: ' + oldMap);
        }
        
        public static void beforeDelete(List<Account> oldRecords) {
            System.debug('Trigger is before delete Old ' + oldRecords);
        }
        
        public static void afterInsert(List<Account> newRecords, Map<Id, Account> newMap) {
            System.debug('Trigger is after insert New ' + newRecords);
            System.debug('Trigger.newMap: ' + newMap);
        }
        
        public static void afterUpdate(List<Account> newRecords, List<Account> oldRecords, Map<Id, Account> newMap, Map<Id, Account> oldMap) {

            System.debug('Trigger is after update New ' + newRecords);
            System.debug('Trigger is after update Old ' + oldRecords);
            System.debug('Trigger.newMap: ' + newMap);
            System.debug('Trigger.oldMap: ' + oldMap);
        }
        
        public static void afterDelete(List<Account> oldRecords) {
            System.debug('Trigger is after delete Old ' + oldRecords);
        }
        
        public static void afterUndelete(List<Account> newRecords, Map<Id, Account> oldMap) {
            System.debug('Trigger is after undelete New ' + newRecords);
            System.debug('Trigger.oldMap: ' + oldMap);
        }
    }