public with sharing class sendEmail {
    public class AttachmentWrapper {
        @AuraEnabled
        public String fileName;
        @AuraEnabled
        public String base64Data;
        @AuraEnabled
        public String contentType;
    }
    public static final String AuthCode = '4/0AcvDMrAZvmwN85ejonS-uDLffEeheH-d4VqDDYzkRoimhioy1JmCm3FFR6YXSuywAK1iww';

    //string actualauthCode = EncodingUtil.urlDecode(AuthCode, 'UTF-8');
    

    public static final String CLIENT_ID = '247099324313-c4t50utg7mdrmli38imcldj54ifhss3h.apps.googleusercontent.com';
    public static final String CLIENT_SECRET = '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';
    public static final String TOKEN_ENDPOINT = 'https://accounts.google.com/o/oauth2/token';
    public static final String GRANT_TYPE = 'authorization_code';
    public static final String REDIRECT_URI = 'https://mvcloudspvtltd4-dev-ed--c.develop.vf.force.com/apex/AuthCode';
    //outh code endpoint ====https://accounts.google.com/o/oauth2/auth

    public static final List<String> SCOPES = new List<String>{
        'https://www.googleapis.com/auth/gmail.send',
        'https://www.googleapis.com/auth/userinfo.email',
        'https://www.googleapis.com/auth/userinfo.profile'
    };

    public class OAuthResponse {
        public String access_token;
        public String refresh_token;
        public String expires_in;
        public String token_type;
    }

    public static OAuthResponse generateAccessToken(String authorizationCode) {
        HttpRequest req = new HttpRequest();
        req.setEndPoint(TOKEN_ENDPOINT);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
       
        String body = 'code=' + authorizationCode +
                      '&client_id=' + CLIENT_ID +
                      '&client_secret=' + CLIENT_SECRET +
                      '&redirect_uri=' + REDIRECT_URI +
                      '&grant_type=' + GRANT_TYPE;
        
        req.setBody(body);
        System.debug('Request Body: ' + body);
       
        Http http = new Http();
        HttpResponse res;
    
        try {
            res = http.send(req);
            System.debug('Response Status Code: ' + res.getStatusCode());
            System.debug('Response Status: ' + res.getStatus());
            System.debug('Response Body: ' + res.getBody());
        } catch (Exception e) {
            System.debug('HTTP Request failed: ' + e.getMessage());
            throw new AuraHandledException('HTTP Request failed: ' + e.getMessage());
        }
    
        if (res.getStatusCode() == 200) {
            return (OAuthResponse) JSON.deserialize(res.getBody(), OAuthResponse.class);
        } else {
            String errorMsg = 'Failed to get access token: ' + res.getBody();
            System.debug(errorMsg);
            throw new AuraHandledException(errorMsg);
        }
    }
    

    @AuraEnabled
    public static String mailSend(String authorizationCode, String recipientEmail, String subject, String plainTextBody, List<AttachmentWrapper> attachments) {
        OAuthResponse authResponse = generateAccessToken(authorizationCode);
        String accessToken = authResponse.access_token;
        
        String endpoint = 'https://www.googleapis.com/gmail/v1/users/me/messages/send';
        
        String emailContent = 'To: ' + recipientEmail + '\n' +
                              'Subject: ' + subject + '\n\n' +
                              plainTextBody;
        
        try {
            String rawEmail = EncodingUtil.base64Encode(Blob.valueOf(emailContent)).replace('+', '-').replace('/', '_').replace('=', '');
            
            Map<String, Object> emailMessage = new Map<String, Object>();
            emailMessage.put('raw', rawEmail);

            if (attachments != null && !attachments.isEmpty()) {
                // Note: Handling attachments in the raw email message would require MIME encoding,
                // which is complex and not straightforward in Apex.
                throw new AuraHandledException('Attachments are not supported in this example.');
            }

            HttpRequest req = new HttpRequest();
            req.setEndPoint(endpoint);
            req.setMethod('POST');
            req.setHeader('Authorization', 'Bearer ' + accessToken);
            req.setHeader('Content-Type', 'application/json');
            req.setBody(JSON.serialize(emailMessage));

            Http http = new Http();
            HttpResponse res = http.send(req);

            if (res.getStatusCode() == 200) {
                return 'Email sent successfully';
            } else {
                throw new AuraHandledException('Failed to send email: ' + res.getBody());
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}