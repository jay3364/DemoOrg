public class TriggerHandler10 {
    public static void triggerHandle(List<Account> accList) {
        List<Contact> conList = new List<Contact>();
        for (Account acc : accList) {
            Contact con = new Contact(
                // FirstName = acc.Name,
                LastName = acc.Name,
                AccountId = acc.Id
            );
            conList.add(con);
        }

        if (!conList.isEmpty()) {
            insert conList;
        }
    }
}