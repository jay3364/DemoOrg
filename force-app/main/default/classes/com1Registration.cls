public with sharing class com1Registration {
    @AuraEnabled
    public static void createCommunityUser(Map<String, String> userData) {

        String role = userData.get('role');
        String contactName;
        String contactEmail;
        String accountId = userData.get('accountId');
        Boolean isPersonAccount = false;
        System.debug(userData);
        if (role == 'Teacher') {
            contactName = userData.get('teacherName');
            contactEmail = userData.get('teacherEmail');
        } else if (role == 'Student') {
            contactName = userData.get('studentName');
            contactEmail = userData.get('studentEmail');
        }

        Account account;
        Account accountcreate;
        Contact contactlist;
        Contact contact;

        Map<String, Schema.SObjectField> accountFields = Schema.getGlobalDescribe().get('Account').getDescribe().fields.getMap();
      
        Boolean isPersonAccountFieldAvailable = accountFields.containsKey('IsPersonAccount');
        System.debug(accountFields);
        System.debug('accountField======>');

        accountcreate = new Account( 
            Name = contactName
        );
        insert accountcreate;

        System.debug('insert Account '+accountcreate);
        accountId = accountcreate.Id;
        if (accountId != null) {
            System.debug('accountId--->' + accountId);
            // account = [SELECT Id FROM Account WHERE Id = :accountId LIMIT 1];
            // System.debug('accc'+account);
            accountcreate = [SELECT Id, IsPersonAccount FROM Account WHERE Id = :accountId LIMIT 1];
            isPersonAccount = accountcreate.IsPersonAccount;
            
            System.debug('isPersonAccount====>'+isPersonAccountFieldAvailable);
            if (isPersonAccountFieldAvailable) {
                isPersonAccount = accountFields.get('IsPersonAccount').getDescribe().isAccessible();
                System.debug('person account==>'+isPersonAccount);
            }

            if (isPersonAccount) {
                System.debug('inside the isPerson');

                contact = new Contact(
                    LastName = contactName,
                    Email = contactEmail,
                    AccountId = accountId
                );
                insert contact;
                contactlist = [SELECT Id FROM Contact WHERE AccountId = :accountId LIMIT 1];
                System.debug(contactlist);
                System.debug('contact' + contact);

            } else {
                contact = new Contact(
                    LastName = contactName,
                    Email = contactEmail,
                    AccountId = accountId
                );
                insert contact;
                System.debug(contact);
            }
        } else {
            account = new Account(
                Name = contactName
            );
            insert account;
            System.debug('O');
            System.debug(account);
            accountId = account.Id;
            contact = new Contact(
                LastName = contactName,
                Email = contactEmail,
                AccountId = account.Id
            );
            insert contact;
        }

        Profile communityProfile = [SELECT Id FROM Profile WHERE UserLicense.Name = 'Customer Community Login' LIMIT 1];
        System.debug('communityProfile==>'+communityProfile);
        User newUser = new User(
            ContactId = contact.Id,
            Username = contactEmail,
            LastName = contactName,
            CommunityNickname = contactName,
            Email = contactEmail,
            Alias = contactName.substring(0, 5),
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            ProfileId = communityProfile.Id,
            LanguageLocaleKey = 'en_US'
        );

        try {
            System.debug(newUser);
            Id createdUserId = Site.createExternalUser(newUser, account.Id);
            sendWelcomeEmail(createdUserId);
        } catch (Exception e) {
            throw new AuraHandledException('Error creating external user: ' + e.getMessage());
        }
    }

    public static void sendWelcomeEmail(Id newUserId) {
        try {
            EmailTemplate template = [SELECT Id FROM EmailTemplate WHERE DeveloperName = 'Welcome' LIMIT 1];
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setTemplateId(template.Id);
            mail.setTargetObjectId(newUserId);
            mail.setSaveAsActivity(false);

            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        } catch (QueryException e) {
            throw new AuraHandledException('Email template "Welcome" does not exist.');
        } catch (EmailException e) {
            throw new AuraHandledException('Error sending welcome email: ' + e.getMessage());
        }
    }

    @AuraEnabled
    public static LoginResult authenticateUser(String username, String password, String userType) {
        LoginResult result = new LoginResult();
        System.debug('useraname==>'+username);
        System.debug(userType);
        User user = [SELECT Id, Username, UserType FROM User WHERE Username = :username LIMIT 1];
        System.debug(user);
        try {
            if (user == null) {
                result.success = false;
                result.message = 'User not found or inactive';
            } else {
                if ((userType == 'Teacher' && user.UserType == 'Teacher') ||
                    (userType == 'Student' && user.UserType == 'Student')) {
                    result.success = true;
                } else {
                    if(userType == 'Standard'){

                        System.debug('userTypes==>'+userType);
                        result.success = true;
                    }
                    result.message = 'Invalid user type';
                }
            }
        } catch (Exception e) {
            result.success = false;
            result.message = 'An error occurred: ' + e.getMessage();
        }

        return result;
    }

    public class LoginResult {
        @AuraEnabled public Boolean success;
        @AuraEnabled public String message;
    }
}