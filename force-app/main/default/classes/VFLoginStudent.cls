public class VFLoginStudent {
    public String userName{get; set;}
    public String password{get; set;}
    
    public PageReference login(){
        Student__c student = [Select Id,Name, Password__c from Student__c where Name = :userName];
        if(student != null && student.Password__c == password){
            PageReference page = page.Task2OppPagination;
            page.setRedirect(true);
            return page;
        }else{
            return null;
        }
    }
}