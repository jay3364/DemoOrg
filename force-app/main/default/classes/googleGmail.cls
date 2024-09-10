public with sharing class googleGmail {

    public class AttachmentWrapper {
        @AuraEnabled
        public String fileName;
        @AuraEnabled
        public String documentId;
        @AuraEnabled
        public String contentType;
    }

    @AuraEnabled
    public static String mailSend(String recipientEmail, String subject, String plainTextBody, List<AttachmentWrapper> attachments) {
        String boundary = 'example_boundary_' + EncodingUtil.urlEncode(String.valueOf(System.currentTimeMillis()), 'UTF-8');
        String emailContent = 'To: ' + recipientEmail + '\n' +
                              'Subject: ' + subject + '\n' +
                              'MIME-Version: 1.0\n' +
                              'Content-Type: multipart/mixed; boundary="' + boundary + '"\n\n' +
                              '--' + boundary + '\n' +
                              'Content-Type: text/plain; charset=UTF-8\n\n' +
                              plainTextBody + '\n';

        System.debug(attachments);

        if (attachments != null && !attachments.isEmpty()) {
            for (AttachmentWrapper attachment : attachments) {
                try {
                    System.debug(attachment.documentId);
                    ContentVersion version = [SELECT Id, Title, FileType, VersionData, ContentDocumentId FROM ContentVersion WHERE ContentDocumentId = :attachment.documentId LIMIT 1];
                    System.debug(version);
                    Blob base64Data = version.VersionData;
                    String base64EncodedData = EncodingUtil.base64Encode(base64Data);

                    System.debug('Attachment File Name: ' + attachment.fileName);
                    System.debug('Attachment Content Type: ' + attachment.contentType);
                    System.debug('Attachment docId: ' + attachment.documentId);

                    if (String.isEmpty(attachment.contentType)) {
                        if (attachment.fileName.endsWith('.jpg') || attachment.fileName.endsWith('.jpeg')) {
                            attachment.contentType = 'image/jpeg';
                        } else if (attachment.fileName.endsWith('.png')) {
                            attachment.contentType = 'image/png';
                        } else {
                            attachment.contentType = 'application/octet-stream'; // Default for unknown types
                        }
                    }

                    emailContent += '--' + boundary + '\n' +
                                    'Content-Type: ' + attachment.contentType + '; name="' + attachment.fileName + '"\n' +
                                    'Content-Disposition: attachment; filename="' + attachment.fileName + '"\n' +
                                    'Content-Transfer-Encoding: base64\n\n' +
                                    base64EncodedData + '\n\n';
                } catch (QueryException qe) {
                    System.debug('QueryException: ' + qe.getMessage());
                    throw new AuraHandledException('Error fetching attachment: ' + qe.getMessage());
                } catch (Exception e) {
                    System.debug('Exception: ' + e.getMessage());
                    System.debug('Stack Trace: ' + e.getStackTraceString());
                    throw new AuraHandledException('Exception while processing attachment: ' + e.getMessage());
                }
            }
        }

        emailContent += '--' + boundary + '--';
        String rawEmail = EncodingUtil.base64Encode(Blob.valueOf(emailContent)).replace('+', '-').replace('/', '_').replace('=', '');

        Map<String, Object> emailMessage = new Map<String, Object>();
        emailMessage.put('raw', rawEmail);

        try {
            HttpRequest req = new HttpRequest();
            req.setEndpoint('callout:Gmail1/gmail/v1/users/me/messages/send');
            req.setMethod('POST');
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
            System.debug('Exception: ' + e.getMessage());
            System.debug('Stack Trace: ' + e.getStackTraceString());
            throw new AuraHandledException('Exception while sending email: ' + e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static String getEmailofRecord(String recordId) {
        try {
            Contact contact = [SELECT Id, Email FROM Contact WHERE Id = :recordId LIMIT 1];
            return contact.Email;
        } catch (QueryException qe) {
            System.debug('QueryException: ' + qe.getMessage());
            throw new AuraHandledException('Error fetching email: ' + qe.getMessage());
        } catch (Exception e) {
            System.debug('Exception: ' + e.getMessage());
            System.debug('Stack Trace: ' + e.getStackTraceString());
            throw new AuraHandledException('Error fetching email: ' + e.getMessage());
        }
    }
}