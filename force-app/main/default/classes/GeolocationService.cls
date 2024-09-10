public with sharing class GeolocationService {
//    @AuraEnabled
//    public static Map<String,double> getCoordinatesFromAddress(String address){
//     try {
//         String apiKey = 'YOUR_GOOGLE_MAPS_API_KEY';
//         String endpoint = 'https://maps.googleapis.com/maps/api/geocode/json?address=' + EncodingUtil.urlEncode(address, 'UTF-8') + '&key=' + apiKey;
        
//         HttpRequest req = new HttpRequest();
//         req.setEndpoint(endpoint);
//         req.setMethod('GET');
        
//         Http http = new Http();
//         HttpResponse res = http.send(req);
//         System.debug(res.getBody());
//         if (res.getStatusCode() == 200) {
//             // System.debug('responseMap==>',res.getBody());
//             Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
//             if (responseMap.containsKey('results') && !((List<Object>)responseMap.get('results')).isEmpty()) {
//                 Map<String, Object> location = (Map<String, Object>) ((Map<String, Object>)((List<Object>)responseMap.get('results'))[0]).get('geometry');
//                 Map<String, Object> latLng = (Map<String, Object>) location.get('location');
                
//                 Map<String, Double> coordinates = new Map<String, Double>();
//                 coordinates.put('latitude', (Double) latLng.get('lat'));
//                 coordinates.put('longitude', (Double) latLng.get('lng'));
                
//                 return coordinates;
//             }
//             return null;
//         }
        
    

//     } catch (Exception e) {
//         throw new AuraHandledException(e.getMessage());
//     }
//     return null;
// }
private static final String NOMINATIM_URL = 'https://nominatim.openstreetmap.org/search?format=json&q=';

public static Map<String, Decimal> getGeolocation(String address) {
    System.debug('Getting geolocation for address: ' + address);
    
    HttpRequest req = new HttpRequest();
    req.setEndpoint(NOMINATIM_URL + EncodingUtil.urlEncode(address, 'UTF-8'));
    req.setMethod('GET');
    req.setHeader('Content-Type', 'application/json');
    
    Http http = new Http();
    HttpResponse res = http.send(req);
    
    Map<String, Decimal> result = new Map<String, Decimal>();
    
    if (res.getStatusCode() == 200) {
        // Deserialize the response body into a list of maps
        List<Object> locations = (List<Object>) JSON.deserializeUntyped(res.getBody());
        
        if (!locations.isEmpty()) {
            // Cast the first element to a map
            Map<String, Object> location = (Map<String, Object>) locations[0];
            Decimal lat = Decimal.valueOf((String) location.get('lat'));
            Decimal lon = Decimal.valueOf((String) location.get('lon'));

            result.put('latitude', lat);
            result.put('longitude', lon);
            System.debug('Geolocation result: ' + result);
        } else {
            System.debug('No locations found for address.');
        }
    } else {
        System.debug('Failed to get geolocation: ' + res.getBody());
    }

    return result;
}

// @future(callout=true)
// public static void getGeolocationAsync(String address, Id contactId) {
//     Map<String, Decimal> geoLocation = getGeolocation(address);
//     if (!geoLocation.isEmpty()) {
//         // Query and update the Contact record asynchronously
//         Contact con = [SELECT Id, Latitude__c, Longitude__c FROM Student__c WHERE Id = :contactId LIMIT 1];
//         con.Latitude__c = geoLocation.get('latitude');
//         con.Longitude__c = geoLocation.get('longitude');
//         update con;
//     }
// }




    @future(callout=true)
    static public void newAccmethod(Id accountIds) {
        // Query the accounts using the provided IDs
        for (Account a : [
            SELECT BillingCity, BillingCountry, BillingPostalCode, BillingState, BillingStreet 
            FROM Account 
            WHERE Id = :accountIds
        ]) {
            // Build the address string
            String address = '';
            if (a.BillingStreet != null) address += a.BillingStreet + ', ';
            if (a.BillingCity != null) address += a.BillingCity + ', ';
            if (a.BillingState != null) address += a.BillingState + ' ';
            if (a.BillingPostalCode != null) address += a.BillingPostalCode + ', ';
            if (a.BillingCountry != null) address += a.BillingCountry;
            System.debug(address);
            // URL encode the address
            address = EncodingUtil.urlEncode(address, 'UTF-8');

            // Build the HTTP request for the Google Maps Geocoding API
            Http h = new Http();
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://maps.googleapis.com/maps/api/geocode/json?address=' + address + '&sensor=false');
            req.setMethod('GET');
            req.setTimeout(5000);

            try {
                // Make the HTTP callout
                HttpResponse res = h.send(req);

                // Parse coordinates from the JSON response
                double lat = 0;
                double lon = 0;
                JSONParser parser = JSON.createParser(res.getBody());
                
                while (parser.nextToken() != null) {
                    if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'location')) {
                        parser.nextToken(); // Move to object start
                        while (parser.nextToken() != JSONToken.END_OBJECT) {
                            String field = parser.getText();
                            parser.nextToken(); // Move to value
                            if (field == 'lat') {
                                lat = parser.getDoubleValue();
                            } else if (field == 'lng') {
                                lon = parser.getDoubleValue();
                            }
                        }
                    }
                }
                System.debug(res.getBody());
                System.debug(lat+ '  ==='+lon);
                // Update the account with the coordinates if available
                if (lat != 0 && lon != 0) {
                    a.GeoLocation__Latitude__s = lat;
                    a.GeoLocation__Longitude__s = lon;
                    update a;
                }

            } catch (Exception e) {
                // Handle exceptions and log them for debugging
                System.debug('Exception during geolocation callout: ' + e.getMessage());
            }
        }
    }
}