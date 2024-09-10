import { LightningElement, wire, track } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import getAccounts from '@salesforce/apex/Task4Lwc.getaccList';
import ACCOUNT_SELECTED_CHANNEL from '@salesforce/messageChannel/task4Lms__c';

export default class AccountDropdown extends LightningElement {
    @track selectedAccountId;
    @track accountOptions = [];
    @track selectedAccount;

    @wire(MessageContext)
    messageContext;

    @wire(getAccounts)
    wiredAccounts({ error, data }) {
        if (data) {
            this.accountOptions = data.map(account => ({
                label: account.Name,
                value: account.Id
            }));
        } else if (error) {
            console.error(error);
        }
    }

    handleAccountChange(event) {
        this.selectedAccountId = event.detail.value;
        this.selectedAccount = this.accountOptions.find(account => account.value === this.selectedAccountId);
        const payload = { accountId: this.selectedAccountId };
        publish(this.messageContext, ACCOUNT_SELECTED_CHANNEL, payload);
    }
}