public with sharing class dropBox {

    public class DropboxFile {
        @AuraEnabled
        public String id { get; set; }
        @AuraEnabled
        public String name { get; set; }
        @AuraEnabled
        public String url { get; set; }
    }

    @AuraEnabled(cacheable=true)
    public static List<DropboxFile> fetchDropboxFiles() {
        System.debug('fetchDropboxFiles called');

        
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.dropboxapi.com/2/files/list_folder');
        req.setMethod('POST');
        req.setHeader('Authorization', 'Bearer ' + getAccessToken());
        req.setHeader('Content-Type', 'application/json');
        req.setBody('{"path": ""}');

        System.debug(req);
        HttpResponse res = new Http().send(req);
        List<DropboxFile> files = new List<DropboxFile>();

        System.debug(res);
        if (res.getStatusCode() == 200) {
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            List<Object> entries = (List<Object>) results.get('entries');

            for (Object entry : entries) {
                Map<String, Object> fileEntry = (Map<String, Object>) entry;
                DropboxFile file = new DropboxFile();
                file.id = (String) fileEntry.get('id'); 
                file.name = (String) fileEntry.get('name');
                file.url = 'https://www.dropbox.com/home' + (String) fileEntry.get('path_lower');
                files.add(file);
            }
        } else {
            System.debug('Error fetching files: ' + res.getBody());
        }

        return files;
    }


    @AuraEnabled
    public static String uploadToDropbox(String fileName, String fileBodyBase64) {
        String endpoint = 'callout:dropbox/2/files/upload';
        System.debug(endpoint);
        
        Blob fileBody = EncodingUtil.base64Decode(fileBodyBase64);
        System.debug(fileBody);
       
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('POST');
        req.setHeader('Authorization', 'Bearer ' + getAccessToken());
        req.setHeader('Dropbox-API-Arg', '{"path": "/' + fileName + '", "mode": "add", "autorename": true, "mute": false, "strict_conflict": false}');
        req.setHeader('Content-Type', 'application/octet-stream');
        req.setBodyAsBlob(fileBody);

        Http http = new Http();
        HttpResponse res = http.send(req);
        System.debug(res);
        
        if (res.getStatusCode() == 200) {
            return 'File uploaded successfully';
        } else {
            return 'File upload failed: ' + res.getBody();
        }
    }

    @AuraEnabled
    public static String deleteFromDropbox(String fileId) {
        System.debug('fieldid'+fileId);
        String endpoint = 'callout:dropbox/2/files/delete_v2';
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('POST');
        req.setHeader('Authorization', 'Bearer ' + getAccessToken());
        req.setHeader('Content-Type', 'application/json');
        req.setBody(JSON.serialize(new Map<String, String>{'path' => '/' + fileId}));

        Http http = new Http();
        HttpResponse res = http.send(req);
        System.debug(req);
        if (res.getStatusCode() == 200) {
            return 'File deleted successfully';
        } else {
            return 'File deletion failed: ' + res.getBody();
        }
    }

    private static String getAccessToken() {
        
        return 'sl.B5pV-2X5FJ9EgTzZCqqhxEXbM3XXgqLbselGdw0NeFYcUbcL6D3AInTUj67xRCNzNhi9KQWSkYXp_uKYoqhYC0Xgnlx9n1vrk3bJ4sq9vqLp3pZ3ZbmPp-rTm2nGOZ35ZQEd-1eOx0L02rP5wzHX';
    }

    public static void called(){
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        String clientId = '3MVG9GCMQoQ6rpzT_LGEpyiR3tUjuZWq47Ri7f_JvhzZUE10RBIflTOriv4J5B3mHu0WyinBoHsBPnly7G4Qt'; 
        String clientSecret = '332A49CF59F757A47B5F3C7B0838F49560328DCB313F1D5BE87B15F789933416';
        String username = 'mvcloud@jay.com';
        String password = 'Salesforce@977323' + 'D9IpzR5HUeEaZTCSko8kFT3Fz'; 
        String body = '&grantType = password';
        req.setBody(body);

        Http http = new Http();
        
        // Send the request and receive the response
        try {
            HttpResponse res = http.send(req);
            
            // Check the response status code
            if (res.getStatusCode() == 200) {
                System.debug('Response: ' + res.getBody());
                // Parse the JSON response to extract the access token
                Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
                String accessToken = (String) responseMap.get('access_token');
                System.debug('Access Token: ' + accessToken);
            } else {
                System.debug('Error: ' + res.getStatus());
                System.debug('Response Body: ' + res.getBody());
            }
        } catch (Exception e) {
            System.debug('Exception: ' + e.getMessage());
        }
    
    }
}