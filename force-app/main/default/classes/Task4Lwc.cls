public class Task4Lwc {
    @AuraEnabled(cacheable=true)
    public static  list<Account> getaccList(){
        return [select Id,Name from Account];
    }

    @AuraEnabled(cacheable=true)
    public static Map<String, list<sObject>>oppList(Id accountId){
        Map<String, list<sObject>> recordMap = new Map<String, list<sObject>>();

        List<Contact> conlist = [SELECT Id,Name,Email from Contact where AccountId = :accountId];
        List<Opportunity> oppList = [SELECT Id,Name,Amount,stageName from Opportunity where AccountId = :accountId];
        System.debug(conlist);
        recordMap.put('contact',conlist);
        recordMap.put('opo',oppList);
        System.debug('this is latest dta==>'+recordMap);

return recordMap;
    }

    @AuraEnabled(cacheable=true)
    public static list<EntityDefinition> getAllObjects(){
        List<EntityDefinition> entityDefinitions = [SELECT QualifiedApiName FROM EntityDefinition WHERE IsCustomizable = true];
        try {
            list<EntityDefinition> objsList = new list<EntityDefinition>();
            for (EntityDefinition entity : entityDefinitions) {
                objsList.add(entity);
            }
            System.debug(objsList);
            return objsList;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

   
    
    @AuraEnabled(cacheable=true)
    public static Map<String, List<sObject>> searchObjects(String searchKey, List<String> selectedObjects) {
        Map<String, List<sObject>> results = new Map<String, List<sObject>>();
        
        if (selectedObjects.isEmpty()) {
            return results;
        }

        String soslQuery = 'FIND {' + String.escapeSingleQuotes(searchKey) + '} IN ALL FIELDS RETURNING ';
        List<String> returningStatements = new List<String>();
        for (String objectName : selectedObjects) {
            returningStatements.add(objectName + '(Id, Name)');
        }
        soslQuery += String.join(returningStatements, ', ');

        List<List<sObject>> soslResults = Search.query(soslQuery);
        Integer i = 0;
        for (String objectName : selectedObjects) {
            results.put(objectName, (List<sObject>)soslResults[i]);
            i++;
        }
        
        return results;
    }

    @AuraEnabled(cacheable=true)
    public static List<List<sObject>> recordget(List<String> objectNames) {
        List<List<sObject>> results = new List<List<sObject>>();
        for (String objectName : objectNames) {
            String query = 'SELECT Id, Name FROM ' + objectName;
            results.add(Database.query(query));
        }
        System.debug(results);
        return results;
    }


}