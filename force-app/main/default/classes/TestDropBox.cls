@isTest
public with sharing class TestDropBox {

    @isTest
    static void testFetchDropboxFiles() {
        
        Test.setMock(HttpCalloutMock.class, new DropboxHttpMockFetch());

        Test.startTest();
        List<dropBox.DropboxFile> files = dropBox.fetchDropboxFiles();
        Test.stopTest();

        System.assertNotEquals(null, files, 'Files should not be null');
        System.assertNotEquals(0, files.size(), 'Files list should not be empty');
        System.assertEquals('Test File', files[0].name, 'First file name should be "Test File"');
    }

    @isTest
    static void testUploadToDropbox() {
        
        Test.setMock(HttpCalloutMock.class, new DropboxHttpMockUpload());

        String fileName = 'TestFile.txt';
        String fileBodyBase64 = EncodingUtil.base64Encode(Blob.valueOf('Test Content'));

        Test.startTest();
        String result = dropBox.uploadToDropbox(fileName, fileBodyBase64);
        Test.stopTest();

        System.assertEquals('File uploaded successfully', result, 'File should be uploaded successfully');
    }

    @isTest
    static void testCalled() {
        
        Test.setMock(HttpCalloutMock.class, new DropboxHttpMockCalled());

        Test.startTest();
        dropBox.called();
        Test.stopTest();

        
    }

    @isTest
    static void testDeleteFromDropbox() {
        
        Test.setMock(HttpCalloutMock.class, new DropboxHttpMockDelete());

        String fileId = 'test_file_id';

        Test.startTest();
        String result = dropBox.deleteFromDropbox(fileId);
        Test.stopTest();

        System.assertEquals('File deleted successfully', result, 'File should be deleted successfully');
    }

    private class DropboxHttpMockFetch implements HttpCalloutMock {
        public HttpResponse respond(HttpRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"entries": [{"id": "id1", "name": "Test File", "path_lower": "/testfile"}]}');
            res.setStatusCode(200);
            return res;
        }
    }

    private class DropboxHttpMockUpload implements HttpCalloutMock {
        public HttpResponse respond(HttpRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"id": "id1", "name": "Test File", "path_lower": "/testfile"}');
            res.setStatusCode(200);
            return res;
        }
    }

    private class DropboxHttpMockDelete implements HttpCalloutMock {
        public HttpResponse respond(HttpRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"metadata": {"id": "id1", "name": "Test File"}}');
            res.setStatusCode(200);
            return res;
        }
    }

    private class DropboxHttpMockCalled implements HttpCalloutMock {
        public HttpResponse respond(HttpRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"access_token": "test_access_token"}');
            res.setStatusCode(200);
            return res;
        }
    }
}