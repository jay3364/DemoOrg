public class VFRegistration {
    public String firstName { get; set; }
    public String lastName { get; set; }
    public String email { get; set; }
    public String password { get; set; }

    @RemoteAction
    public static String saveStudent(String firstName, String lastName, String email, String password) {
        try {
            System.debug('Saving student: ' + firstName + ' ' + lastName + ' ' + email + ' ' + password); // Debugging

            Student__c st = new Student__c();
            st.Name = firstName;
            st.Last_Name__c = lastName;
            st.Email_Id__c = email;
            st.Password__c = password;
            insert st;

            return 'Success';
        } catch (Exception e) {
            System.debug('Error: ' + e.getMessage());
            return 'Error: ' + e.getMessage();
        }
    }
    
    public Static String LoginStudent(String Name, String Password){
        Student__c std = new Student__c();
        std.Name = Name;
        std.Password__c = Password;
        
        return 'success';
    }
}