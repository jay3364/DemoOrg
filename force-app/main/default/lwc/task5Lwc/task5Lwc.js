import { LightningElement, track, wire, api } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import getdata from '@salesforce/apex/task3lwc.getRecordObject';
 import sendEmail from '@salesforce/apex/task3lwc.sendEmail';
 import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class Task5Lwc extends LightningElement {
    steps = [
        { label: 'Step 1', value: 'step1' },
        { label: 'Step 2', value: 'step2' },
        { label: 'Step 3', value: 'step3' }
    ];
    
    @api disable = false;
    @track data = [];
    @track currentStep = 'step1';
    @track step1 = true;
    @track step2 = false;
    @track step3 = false;
    @track selectedLabel;
    @track emailSubject = '';
    @track emailRecipient = '';
    @track emailBody = '';
    @track selected_row;

    @track options = [
        { label: 'Account', value: 'Account' },
        { label: 'Contact', value: 'Contact' },
        { label: 'Opportunity', value: 'Opportunity' }
    ];

    @track columns = [
        { label: 'Name', fieldName: 'Name' },
        { label: 'Created Date', fieldName: 'CreatedDate', type: 'date' },
        { label: 'Last Modified Date', fieldName: 'LastModifiedDate', type: 'date' },
        { label: 'Email', fieldName: 'Email', type: 'email' }
    ];

    @track value;
    @track objectInfo;
    @track data = [];
    @track error;

    connectedCallback() {
        this.disable = (this.currentStep === 'step1');
    }

    @wire(getRecord, { recordId: '$recordId', fields: [ACCOUNT_OBJECT] })
    wiredRecord({ data, error }) {
        if (data) {
            this.objectInfo = data;
            console.log('This is Account:', data);
        } else if (error) {
            console.error('Error fetching account record:', error);
        }
    }

    handleSteps(event) {
        this.currentStep = event.target.value;
        console.log(this.currentStep);
        this.updateSteps();
    }

    handleChange(event) {
        this.value = event.detail.value;
        console.log(JSON.stringify(this.value));

        const selectedOption = this.options.find(option => option.value === this.value);
        if (selectedOption) {
            this.selectedLabel = selectedOption.label;
        }
        console.log('Selected Label:', this.selectedLabel);

        this.fetchData();
    }

    fetchData() {
        getdata({ objectName: this.selectedLabel })
            .then(result => {
                this.data = result;
                console.log('Records fetched:', result);
            })
            .catch(error => {
                this.error = error;
                console.error('Error fetching records:', error);
            });
    }

    nextStep() {
        if (this.currentStep === 'step1') {
            this.currentStep = 'step2';
        } else if (this.currentStep === 'step2') {
            this.currentStep = 'step3';
        }
        this.updateSteps();
    }

    previousStep() {
        if (this.currentStep === 'step2') {
            this.currentStep = 'step1';
        } else if (this.currentStep === 'step3') {
            this.currentStep = 'step2';
        }
        this.updateSteps();
    }

    updateSteps() {
        this.step1 = (this.currentStep === 'step1');
        this.step2 = (this.currentStep === 'step2');
        this.step3 = (this.currentStep === 'step3');
        this.disable = (this.currentStep === 'step1');
    }

    handleEmailSubjectChange(event) {
        this.emailSubject = event.target.value;
    }

    handleEmailRecipientChange(event) {
        this.emailRecipient = event.target.value;
    }

    handleEmailBodyChange(event) {
        this.emailBody = event.target.value;
    }

    saveData() {
        console.log('Saving email draft:');
        console.log('Subject:', this.emailSubject);
        console.log('Recipient:', this.emailRecipient);
        console.log('Body:', this.emailBody);

        sendEmail({
            subject: this.emailSubject,
            recipient: this.emailRecipient,
            body: this.emailBody
        })
        .then(result => {
            console.log('Email sent successfully:', result);
            this.emailSubject = '';
            this.emailRecipient = '';
            this.emailBody = '';

            
            this.dispatchEvent(new ShowToastEvent({
                title: "SEND",
                message: "Send Email",
                variant: "success"
            }));
        })
        .catch(error => {
            console.error('Error sending email:', error);
        });
    }

    getSelectedName(event) {
        const selectedRows = event.detail.selectedRows;
        const emailAddresses = selectedRows.map(row => row.Email).join(';');
        console.log('emailAddresses==>', emailAddresses);
        this.emailRecipient = emailAddresses;
    }
}