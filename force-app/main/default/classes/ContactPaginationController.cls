public class ContactPaginationController {
    public List<Contact> contacts { get; set; }
    public Integer currentPage { get; set; }
    public Integer totalPage { get; set; }
    public Integer totalRecord { get; set; }
    public Integer pageSize { get; set; }
    
    public ContactPaginationController() {
        currentPage = 1;   // Number of page
        pageSize = 10;
        contacts = new List<Contact>();
        totalRecord = [SELECT COUNT() FROM Contact];
        totalPage = (totalRecord + pageSize - 1) / pageSize;
        fetchContacts();
    }
    
    public void fetchContacts() {
        contacts = [SELECT Id, Name, Email, Phone FROM Contact LIMIT :pageSize OFFSET :((currentPage - 1) * pageSize)];
    }
   
    public void nextPage() {
        if (currentPage < totalPage) {
            currentPage++;
            fetchContacts();
        }
    }

    public void previousPage() {
        if (currentPage > 1) {
            currentPage--;
            fetchContacts();
        }
    }
    
    public Boolean getHasNextPage() {
        return currentPage < totalPage;
    }

    public Boolean getHasPreviousPage() {
        return currentPage > 1;
    }
}