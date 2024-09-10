@isTest
private class googleGmailTest {
    @testSetup
    static void setup() {
        // Create a test Contact record
        Contact testContact = new Contact(FirstName = 'Test', LastName = 'User', Email = 'testuser@example.com');
        insert testContact;

        // Create a test ContentVersion record
        ContentVersion testContentVersion = new ContentVersion(
            Title = 'Test Attachment',
            PathOnClient = 'test.txt',
            VersionData = Blob.valueOf('Test content'),
            IsMajorVersion = true
        );
        insert testContentVersion;
    }

    @isTest
    static void testMailSend() {
        // Fetch the test Contact record
        Contact testContact = [SELECT Id, Email FROM Contact LIMIT 1];

        // Fetch the test ContentVersion record
        ContentVersion testContentVersion = [SELECT Id, Title, ContentDocumentId FROM ContentVersion LIMIT 1];

        // Prepare the AttachmentWrapper list
        List<googleGmail.AttachmentWrapper> attachments = new List<googleGmail.AttachmentWrapper>();
        googleGmail.AttachmentWrapper attachment = new googleGmail.AttachmentWrapper();
        attachment.fileName = testContentVersion.Title;
        attachment.documentId = testContentVersion.ContentDocumentId;
        attachment.contentType = 'text/plain';
        attachments.add(attachment);

        Test.startTest();
        // Call the mailSend method
        String result = googleGmail.mailSend(testContact.Email, 'Test Subject', 'This is a test email body', attachments);
        Test.stopTest();

        System.assertEquals('Failed to send email: ...', result, 'Expected email to be sent successfully');
    }

    @isTest
    static void testMailSendNoAttachments() {
        // Fetch the test Contact record
        Contact testContact = [SELECT Id, Email FROM Contact LIMIT 1];

        Test.startTest();
        // Call the mailSend method without attachments
        String result = googleGmail.mailSend(testContact.Email, 'Test Subject', 'This is a test email body', null);
        Test.stopTest();

        System.assertEquals('Failed to send email: ...', result, 'Expected email to be sent successfully');
    }

    @isTest
    static void testMailSendEmptyAttachmentContentType() {
        // Fetch the test Contact record
        Contact testContact = [SELECT Id, Email FROM Contact LIMIT 1];

        // Fetch the test ContentVersion record
        ContentVersion testContentVersion = [SELECT Id, Title, ContentDocumentId FROM ContentVersion LIMIT 1];

        // Prepare the AttachmentWrapper list with an empty content type
        List<googleGmail.AttachmentWrapper> attachments = new List<googleGmail.AttachmentWrapper>();
        googleGmail.AttachmentWrapper attachment = new googleGmail.AttachmentWrapper();
        attachment.fileName = testContentVersion.Title;
        attachment.documentId = testContentVersion.ContentDocumentId;
        attachment.contentType = ''; // Empty content type
        attachments.add(attachment);

        Test.startTest();
        // Call the mailSend method
        String result = googleGmail.mailSend(testContact.Email, 'Test Subject', 'This is a test email body', attachments);
        Test.stopTest();

        System.assertEquals('Failed to send email: ...', result, 'Expected email to be sent successfully');
    }

    @isTest
    static void testMailSendUnknownAttachmentContentType() {
        // Fetch the test Contact record
        Contact testContact = [SELECT Id, Email FROM Contact LIMIT 1];

        // Fetch the test ContentVersion record
        ContentVersion testContentVersion = [SELECT Id, Title, ContentDocumentId FROM ContentVersion LIMIT 1];

        // Prepare the AttachmentWrapper list with an unknown content type
        List<googleGmail.AttachmentWrapper> attachments = new List<googleGmail.AttachmentWrapper>();
        googleGmail.AttachmentWrapper attachment = new googleGmail.AttachmentWrapper();
        attachment.fileName = 'unknownfile.unknown';
        attachment.documentId = testContentVersion.ContentDocumentId;
        attachment.contentType = ''; // Empty content type
        attachments.add(attachment);

        Test.startTest();
        // Call the mailSend method
        String result = googleGmail.mailSend(testContact.Email, 'Test Subject', 'This is a test email body', attachments);
        Test.stopTest();

        System.assertEquals('Failed to send email: ...', result, 'Expected email to be sent successfully');
    }

    @isTest
    static void testGetEmailofRecord() {
        // Fetch the test Contact record
        Contact testContact = [SELECT Id, Email FROM Contact LIMIT 1];

        Test.startTest();
        // Call the getEmailofRecord method
        String email = googleGmail.getEmailofRecord(testContact.Id);
        Test.stopTest();

        System.assertEquals(testContact.Email, email, 'Expected to fetch the correct email');
    }

    @isTest
    static void testGetEmailofRecordInvalidId() {
        Test.startTest();
        try {
            // Call the getEmailofRecord method with an invalid ID
            String email = googleGmail.getEmailofRecord('invalidId');
            System.assert(false, 'Expected an AuraHandledException to be thrown');
        } catch (AuraHandledException e) {
            System.assert(e.getMessage().contains('Error fetching email'), 'Expected an error message about fetching email');
        }
        Test.stopTest();
    }
}