import { LightningElement, wire, track } from 'lwc';
import { subscribe, MessageContext } from 'lightning/messageService';
import getContactsAndOpportunities from '@salesforce/apex/Task4Lwc.oppList';
import ACCOUNT_SELECTED_CHANNEL from '@salesforce/messageChannel/task4Lms__c';

export default class AccountDetails extends LightningElement {
    @track accountId;
    @track contacts=[];
    @track opportunities = [];


    contactColumns = [
        { label: 'Name', fieldName: 'Name' },
        { label: 'Email', fieldName: 'Email', type: 'email' }
    ];

    opportunityColumns = [
        { label: 'Name', fieldName: 'Name' },
        { label: 'Stage', fieldName: 'StageName', type : 'picklist'},
        { label: 'Amount', fieldName: 'Amount', type: 'currency' }
    ];



    @wire(MessageContext)
    messageContext;

    subscription = null;

    connectedCallback() {
        if (!this.subscription) {
            this.subscription = subscribe(
                this.messageContext,
                ACCOUNT_SELECTED_CHANNEL,
                (message) => this.handleAccountSelected(message)
            );
        }
    }

    handleAccountSelected(message) {
        this.accountId = message.accountId;
        console.log('Selected Account ID:', this.accountId);
        this.loadAccountDetails();
    }

    loadAccountDetails() {
        getContactsAndOpportunities({ accountId: this.accountId })
            .then(data => {
        console.log('OUTPUT : ',data);
                // this.contacts = data.conlist;
                console.log('Contacts:', data.contact);
                    // data.forEach(currentItem => {

                        this.contacts = data.contact.map(contact=>({
                            Name : contact.Name,
                            Email : contact.Email,

                        }));

                        this.opportunities = data.opo.map(opportunity=>({
                            Name : opportunity.Name,
                            StageName : opportunity.StageName,
                            Amount : opportunity.Amount
                        }))
                        console.log('OUTPUT : ',this.opportunities);
                            


                
            })
            .catch(error => {
                console.error('Error fetching contacts and opportunities:', error);
            });
    }
}