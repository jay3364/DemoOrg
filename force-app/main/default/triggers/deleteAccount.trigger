trigger deleteAccount on Contact (after delete) {
   //when i delete contact it delete related account but not other contact  delete related that account
   Set<Id> accountIds = new Set<Id>();

   // Collect Account IDs from the deleted contacts
   for (Contact deletedContact : Trigger.old) {
       if (deletedContact.AccountId != null) {
           accountIds.add(deletedContact.AccountId);
       }
   }

   // Retrieve all contacts related to these accounts, excluding the deleted contacts
   List<Contact> relatedContacts = [
       SELECT Id, AccountId 
       FROM Contact 
       WHERE AccountId IN :accountIds AND Id NOT IN :Trigger.old
   ];

   // Remove the AccountId field from the retrieved contacts
   for (Contact relatedContact : relatedContacts) {
       relatedContact.AccountId = null;
   }

   // Update the related contacts to remove the AccountId field
   if (!relatedContacts.isEmpty()) {
       update relatedContacts;
   }

   // Delete the accounts related to the deleted contacts
   List<Account> accountsToDelete = [
       SELECT Id 
       FROM Account 
       WHERE Id IN :accountIds
   ];

   if (!accountsToDelete.isEmpty()) {
       delete accountsToDelete;
   }
        }
            // if(!reInsertContact.isEmpty()){
            //     insert reInsertContact;
            // }
    
    //take deleted contact and take related account
    //take all this all contact of this related account except delete contact
    //then delete contact and account  and insert all contact of this related account except delete contact