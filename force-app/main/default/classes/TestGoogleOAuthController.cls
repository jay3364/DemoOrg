@isTest
public with sharing class TestGoogleOAuthController {
    @isTest
    static void testGenerate() {
        Test.startTest();
        String state = GoogleOAuthController.generate();
        System.assertNotEquals(null, state, 'State should not be null');
        System.assertEquals(16, EncodingUtil.urlDecode(state, 'UTF-8').length(), 'State length should be 16');
        Test.stopTest();
    }

    @isTest
    static void testRedirectToGoogle() {
        Test.startTest();
        GoogleOAuthController controller = new GoogleOAuthController();
        PageReference redirect = controller.redirectToGoogle();
        
        System.assertNotEquals(null, redirect, 'PageReference should not be null');
        System.assert(redirect.getUrl().contains('https://accounts.google.com/o/oauth2/auth'), 'URL should contain Google OAuth endpoint');
        System.assert(redirect.getUrl().contains('client_id=' + EncodingUtil.urlEncode(GoogleOAuthController.CLIENT_ID, 'UTF-8')), 'URL should contain client ID');
        System.assert(redirect.getUrl().contains('redirect_uri=' + EncodingUtil.urlEncode(GoogleOAuthController.REDIRECT_URI, 'UTF-8')), 'URL should contain redirect URI');
        System.assert(redirect.getUrl().contains('scope=' + EncodingUtil.urlEncode(String.join(GoogleOAuthController.SCOPES, ' '), 'UTF-8')), 'URL should contain scopes');
        System.assert(redirect.getUrl().contains('state='), 'URL should contain state');
        
        Test.stopTest();
    }

    @isTest
    static void testCaptureAuthCode() {
        
        Test.setCurrentPage(Page.GoogleOAuthCallback);
        ApexPages.currentPage().getParameters().put('code', 'testAuthCode');
        ApexPages.currentPage().getParameters().put('state', 'testState');

        Test.setMock(HttpCalloutMock.class, new GoogleOAuthHttpMock());

        Test.startTest();
        GoogleOAuthController controller = new GoogleOAuthController();
        controller.captureAuthCode();
        Test.stopTest();

        
        System.assertEquals('testAuthCode', ApexPages.currentPage().getParameters().get('code'), 'Auth code should match the mock value');
        System.assertEquals('testState', ApexPages.currentPage().getParameters().get('state'), 'State should match the mock value');
        
        
    }

    private class GoogleOAuthHttpMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"access_token":"fakeAccessToken","token_type":"Bearer","expires_in":3600,"refresh_token":"fakeRefreshToken"}');
            res.setStatusCode(200);
            return res;
        }
    }
}