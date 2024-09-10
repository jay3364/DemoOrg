public with sharing class ComTask3 {
    @AuraEnabled(cacheable=true)
    public static String sendForgotPasswordEmail(String username) {
        try {
            List<User> users = [SELECT Id,Name,Email FROM User WHERE Name = :username LIMIT 1];
            System.debug(users);
            if (!users.isEmpty()) {
                Network network = [SELECT Id FROM Network WHERE Name = 'Task2Login' LIMIT 1];
                Site.forgotPassword(username);      //Uses Site.forgotPassword to send the reset email.
                System.debug( Site.forgotPassword(username));
                return 'Success: An email has been sent to ' + users[0].Email;
            } else {
               // throw new AuraHandledException('Username not found.');
                return 'Error: Username not found.';
            }
        } catch (Exception e) {
           // throw new AuraHandledException('Error processing request: ' + e.getMessage());
            return 'Error processing request: ' + e.getMessage();
        }
    }

    @AuraEnabled(cacheable=true)
    public static void sendResetPasswordEmail(String username) {
        
            List<User> users = [SELECT Id,Name,Email FROM User WHERE Username = :username LIMIT 1];
            System.debug(users);
            if (!users.isEmpty()) {
                Network network = [SELECT Id FROM Network WHERE Name = 'Task2Login' LIMIT 1];
                Site.forgotPassword(username, network.Id);
            } else {
                throw new AuraHandledException('Username not found.');
            }
        // } catch (Exception e) {
        //     throw new AuraHandledException('Error processing request: ' + e.getMessage());
        // }
    }
}