trigger Task10 on Account (after insert) {
    // Whenever a new account is created, create a new contact for the account with the same name as the account.
    TriggerHandler10.triggerHandle(Trigger.new);
   /* List<Contact> conList = new List<Contact>();

    if (Trigger.isAfter && Trigger.isInsert) {
        for (Account acc : Trigger.new) {
            Contact con = new Contact(
                //FirstName = acc.Name,
                LastName = acc.Name,
                AccountId = acc.Id
            );
            conList.add(con);
        }

        if (!conList.isEmpty()) {
            insert conList;
        }
    }*/
}