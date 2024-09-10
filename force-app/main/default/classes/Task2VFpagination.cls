public class Task2VFpagination {
    public List<Account> listAcc { get; set; }
    public List<Opportunity> listOpp { get; set; }
    public Id selectedAccountId { get; set; }
    public Integer totalOppRecords { get; set; }
    public Integer oppPageSize { get; set; }
    public Integer oppPageNumber { get; set; }

    public Task2VFpagination() {
        listAcc = [SELECT Id, Name, Phone FROM Account LIMIT 20];
        oppPageSize = 2;
        oppPageNumber = 1;
    }

    public void fetchRelatedOpp() {
        if (selectedAccountId != null) {
            totalOppRecords = [SELECT COUNT() FROM Opportunity WHERE AccountId = :selectedAccountId];
            listOpp = [SELECT Id, Name FROM Opportunity WHERE AccountId = :selectedAccountId LIMIT :oppPageSize OFFSET :((oppPageNumber - 1) * oppPageSize)];
        }
    }

    public void nextPage() {
        oppPageNumber++;
        fetchRelatedOpp();
    }

    public void previousPage() {
        if (oppPageNumber > 1) {
            oppPageNumber--;
            fetchRelatedOpp();
        }
        
    }

    public void selectAccount() {
        oppPageNumber = 1;
        fetchRelatedOpp();
    }
}