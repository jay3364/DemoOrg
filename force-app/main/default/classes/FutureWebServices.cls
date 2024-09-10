public with sharing class FutureWebServices {

    public FutureWebServices() {
        // Constructor if needed
    }

    @future(callout=true)
    public static void apicalling(Id oppId) {
        try {
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('https://api.unsplash.com/photos/random?client_id=pQMBKCROPD6YbYTMs0-XLA-WTv7-ubwc3EWIS2yaQ7o');
            request.setMethod('GET');

            HttpResponse response = http.send(request);

            if (response.getStatusCode() == 200) {
                System.debug('Body ===>' + response.getBody());
                System.debug('Body ===>' + response);

                WrapperClass wrapper = WrapperClass.parse(response.getBody());
                String imageUrl = wrapper.urls.regular;
                System.debug(imageUrl);
               
                /*Map<String, Object> jsonResponse = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                String imageUrl = (String) ((Map<String, Object>) jsonResponse.get('urls')).get('regular');*/

                /*ImageResponseWrapper wrapper = ImageResponseWrapper.parse(response.getBody());
                String imageUrl = wrapper.regular;*/

                // Fetch the image 
                HttpRequest imageRequest = new HttpRequest();
                imageRequest.setEndpoint(imageUrl);
                imageRequest.setMethod('GET');

                HttpResponse imageResponse = http.send(imageRequest);

                if (imageResponse.getStatusCode() == 200) {
                    // Create an Attachment to store the image
                    Attachment attachment = new Attachment();
                    attachment.ParentId = oppId;
                    attachment.Body = imageResponse.getBodyAsBlob();
                    attachment.Name = 'Random_Image.jpg';
                    attachment.ContentType = 'image/jpg';
                    insert attachment;
                } else {
                    System.debug('Failed to fetch image: ' + imageResponse.getStatus());
                }
            } else {
                System.debug('Failed to fetch random image URL: ' + response.getStatus());
            }
        } catch (Exception e) {
            System.debug('Error: ' + e.getMessage());
        }
    }
}