@isTest
public class TestUploadFile {
    @isTest
    static void testGetContentDetails() {
        
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        
        ContentVersion contentVersion = new ContentVersion(
            Title = 'Test Document',
            PathOnClient = 'TestDocument.txt',
            VersionData = Blob.valueOf('Test content')
        );
        insert contentVersion;

        
        contentVersion = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id = :contentVersion.Id];

        
        ContentDocumentLink contentDocumentLink = new ContentDocumentLink(
            ContentDocumentId = contentVersion.ContentDocumentId,
            LinkedEntityId = testAccount.Id,
            ShareType = 'V'
        );
        insert contentDocumentLink;

        
        Test.startTest();
        String result = FileUploder.getContentDetails(testAccount.Id);
        Test.stopTest();

        
        System.assertNotEquals(null, result);
        List<ContentVersion> contentVersions = (List<ContentVersion>) JSON.deserialize(result, List<ContentVersion>.class);
        System.assertEquals(1, contentVersions.size());
        System.assertEquals('Test Document', contentVersions[0].Title);
    }
}