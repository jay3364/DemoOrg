@isTest
public class TestFutureWebServices {

    // Inner class to mock HTTP responses
    public class MockHttpResponseGenerator implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setStatusCode(200);
            
            // Simulate response body similar to the actual API response
            String mockResponseBody = '{' +
                                        '"urls": {' +
                                            '"regular": "https://www.pexels.com/photo/close-up-photo-of-glowing-blue-butterflies-326055/"' +
                                        '}' +
                                      '}';
            res.setBody(mockResponseBody);
            
            return res;
        }
    }
    
    @isTest
    static void testApicalling() {
        // Set up test data
        Opportunity testOpp = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Closed Won',
            CloseDate = Date.today()
        );
        insert testOpp;

        // Set mock HTTP response
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());

        Test.startTest();
        // Call the future method asynchronously
        FutureWebServices.apicalling(testOpp.Id);
        Test.stopTest();

        // Verify the creation of the Attachment
        List<Attachment> attachments = [SELECT Id, ParentId, Name, ContentType,Body FROM Attachment WHERE ParentId = :testOpp.Id];
        System.assertNotEquals(0, attachments.size(), 'Attachment should have been created');
        if (!attachments.isEmpty()) {
            Attachment attachment = attachments[0];
            System.assertEquals('Random_Image.jpg', attachment.Name, 'Attachment name should match');
            System.assertEquals('image/jpg', attachment.ContentType, 'Attachment content type should match');
            System.assertNotEquals(null, attachment.Body, 'Attachment body should not be null');
        } else {
            //System.fail('No attachment found for the Opportunity.');
        }
    }
}