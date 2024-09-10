trigger GeoLocationServices on Contact (after insert, after update) {
    if (Trigger.isAfter) {
        for (Contact con : Trigger.new) {
            System.debug(con);
            System.debug(con.MailingStreet);
            String mailingAddress = con.MailingStreet != null ? con.MailingStreet.toString() : null;
            System.debug(mailingAddress);
            if (mailingAddress != null) {
                // Call the future method for asynchronous processing
                GeolocationService.getGeolocation(mailingAddress);
                System.debug('Success: Geolocation request sent for Contact ID: ' + con.Id);
            } else {
                System.debug('Skipped: Mailing address is null or empty for Contact ID: ' + con.Id);
            }
        }
    }
}