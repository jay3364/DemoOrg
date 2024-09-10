import { api, LightningElement, track } from 'lwc';
import sendMail from '@salesforce/apex/googleGmail.mailSend';
import getEmail from '@salesforce/apex/googleGmail.getEmailofRecord';

export default class GmailIntegration extends LightningElement {
    @track popup = false;
    @track toAddress = '';
    @track subject = '';
    @track body = '';
    @track file = [];
    @api recordId; 

    connectedCallback() {
   
        if (this.recordId) {
            this.loademail();
        }
    }

    loademail() {
        if (this.recordId) {
            getEmail({ recordId: this.recordId })
                .then(result => {
                    this.toAddress = result;
                    console.log('Email Address:', this.toAddress);
                })
                .catch(error => {
                    console.error('Error fetching email address:', error);
                });
        } else {
            console.error('Record ID is not available.');
        }
    }

    handleToAddressChange(event) {
        this.toAddress = event.target.value;
    }

    handleSubjectChange(event) {
        this.subject = event.target.value;
    }

    handleBodyChange(event) {
        this.body = event.target.value;
    }

    handleFilesChange(event) {
        console.log('files===>',event.detail.files);
        this.file = event.detail.files.map(file => ({
            fileName: file.name,
            documentId: file.documentId,
            contentType: file.mimeType
            
        }));
        console.log('file==>',JSON.stringify(this.file));
        // console.log('fileType==>',this.contentType);
    }

    handleCloseModal() {
        this.popup = false;
    }

    handleSendEmail() {
        sendMail({
            recipientEmail: this.toAddress,
            subject: this.subject,
            plainTextBody: this.body,
            attachments: this.file
            
        })
        .then(result => {
            console.log('result==>',result);
            this.handleCloseModal();
        })
        .catch(error => {
            console.error('Error sending email:', error);
        });
    }

    handleClick() {
        this.popup = true;
        this.loademail();
    }
}