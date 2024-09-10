public with sharing class GoogleOAuthController {

    public static final String CLIENT_ID = '247099324313-c4t50utg7mdrmli38imcldj54ifhss3h.apps.googleusercontent.com';
    public static final String REDIRECT_URI = 'https://mvcloudspvtltd4-dev-ed--c.develop.vf.force.com/apex/GoogleOAuthCallback';
    public static final String grant_type = 'authorization_code';
    public static final List<String> SCOPES = new List<String>{
        'https://www.googleapis.com/auth/gmail.send',
        'https://www.googleapis.com/auth/userinfo.email',
        'https://www.googleapis.com/auth/userinfo.profile'
    };

    public static String generate() {
        // Generate a random state string
        Integer length = 16;
        final String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
        String state = '';
        for (Integer i = 0; i < length; i++) {
            Integer randomIndex = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
            System.debug(randomIndex);
            state += chars.substring(randomIndex, randomIndex + 1);
            System.debug('Random Index: ' + randomIndex);
            System.debug('State: ' + state);
        }
        System.debug('generated state == >'+state);
        return EncodingUtil.urlEncode(state, 'UTF-8');

    }
    


    public PageReference redirectToGoogle() {
        // Construct the Google OAuth 2.0 authorization endpoint URL
        String authUrl = 'https://accounts.google.com/o/oauth2/auth'
            + '?response_type=code'
            + '&client_id=' + EncodingUtil.urlEncode(CLIENT_ID, 'UTF-8')
            + '&redirect_uri=' + EncodingUtil.urlEncode(REDIRECT_URI, 'UTF-8')
            + '&grant_type= '+ grant_type
            + '&scope=' + EncodingUtil.urlEncode(String.join(SCOPES, ' '), 'UTF-8')
            + '&state=' + EncodingUtil.urlEncode(generate(), 'UTF-8');
            

            System.debug(authUrl);
        // Redirect the user to the Google authorization URL
        PageReference redirect = new PageReference(authUrl);
        redirect.setRedirect(true);
        return redirect;
    }

    public PageReference captureAuthCode() {
        // Get the authorization code from the URL parameters
        String authCode = ApexPages.currentPage().getParameters().get('code');
        String state = ApexPages.currentPage().getParameters().get('state');

        System.debug(authCode);
        System.debug(state);
        if (authCode != null) {
            try {
                // Use the authorization code to get the access token and send the email
                String result = sendEmail.mailSend(authCode, 'recipient@example.com', 'Subject', 'Body text', new List<sendEmail.AttachmentWrapper>());
                System.debug(result);
            } catch (Exception e) {
                System.debug('Error: ' + e.getMessage());
            }
        } else {
            System.debug('Authorization code not found.');
        }

        return null;
    }
}