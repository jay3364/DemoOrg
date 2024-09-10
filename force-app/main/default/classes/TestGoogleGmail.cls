@isTest
public with sharing class TestGoogleGmail {
  
    @testSetup
    static void setup() {
        
        Contact contact = new Contact(LastName = 'Test', Email = 'test@example.com');
        insert contact;
        
        
        ContentVersion contentVersion = new ContentVersion(
            Title = 'TestAttachment',
            PathOnClient = 'TestAttachment.jpg',
            VersionData = Blob.valueOf('Test Content'),
            IsMajorVersion = true
        );
        insert contentVersion;
    }

    @isTest
    static void testGetEmailofRecord() {
        Contact testContact = [SELECT Id FROM Contact LIMIT 1];
        
        Test.startTest();
        String email = googleGmail.getEmailofRecord(testContact.Id);
        Test.stopTest();
        
        System.assertEquals('test@example.com', email, 'The email address should be test@example.com');
    }

    @isTest
    static void testMailSendWithAttachments() {
        Contact testContact = [SELECT Id FROM Contact LIMIT 1];
        ContentVersion version = [SELECT ContentDocumentId FROM ContentVersion LIMIT 1];

        googleGmail.AttachmentWrapper attachment = new googleGmail.AttachmentWrapper();
        attachment.fileName = 'TestAttachment.jpg';
        attachment.documentId = version.ContentDocumentId;
        attachment.contentType = 'image/jpeg';
        
        List<googleGmail.AttachmentWrapper> attachments = new List<googleGmail.AttachmentWrapper>{attachment};
        
        
        Test.setMock(HttpCalloutMock.class, new GoogleHttpMock());
        
        Test.startTest();
        String result = googleGmail.mailSend('test@example.com', 'Test Subject', 'Test Body', attachments);
        Test.stopTest();
        
        System.assertEquals('Email sent successfully', result, 'Email should be sent successfully');
    }

    @isTest
    static void testMailSendWithoutAttachments() {
        
        Test.setMock(HttpCalloutMock.class, new GoogleHttpMock());
        
        Test.startTest();
        String result = googleGmail.mailSend('test@example.com', 'Test Subject', 'Test Body', new List<googleGmail.AttachmentWrapper>());
        Test.stopTest();
        
        System.assertEquals('Email sent successfully', result, 'Email should be sent successfully');
    }

    private class GoogleHttpMock implements HttpCalloutMock {
        public HttpResponse respond(HttpRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"id": "12345"}');
            res.setStatusCode(200);
            return res;
        }
    }
}