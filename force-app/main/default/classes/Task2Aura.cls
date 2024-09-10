public class Task2Aura {
    
    @AuraEnabled
    public static List<Account> getAccounts(Integer pageNumber, Integer pageSize) {
        Integer offset = (pageNumber - 1) * pageSize;
        return [SELECT Id, Name FROM Account LIMIT :pageSize OFFSET :offset];
    }

    @AuraEnabled
    public static List<Contact> getContacts(String accountId) {
        return [SELECT Id, Name, Email FROM Contact WHERE AccountId = :accountId];
    }

    @AuraEnabled
    public static Integer getAccountCount() {
        return [SELECT count() FROM Account];
    }
    @AuraEnabled
    public static Map<String, Object> searchAccounts(String searchTerm) {
        Integer pageSize = 10;
        
        String searchQuery = '%' + searchTerm + '%';
        List<Account> accounts = [SELECT Id, Name FROM Account WHERE Name LIKE :searchQuery ORDER BY Name LIMIT :pageSize];
        Integer totalRecords = [SELECT COUNT() FROM Account WHERE Name LIKE :searchQuery];
        Integer totalPages = (totalRecords + pageSize - 1) / pageSize;
        
        Map<String, Object> result = new Map<String, Object>();
        result.put('accounts', accounts);
        result.put('totalPages', totalPages);
        
        return result;
    }
}