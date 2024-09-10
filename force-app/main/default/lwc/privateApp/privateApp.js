import { api, LightningElement, track, wire } from 'lwc';
import AccData from '@salesforce/apex/Data.getAccountData';
import getCompanies from '@salesforce/apex/Data.Company';
//import Field from '@salesforce/schema/AccountHistory.Field';
export default class PrivateApp extends LightningElement {
  @track draftValues = [];
  @track companies;
  @track selectedRecord;
  columns = [
    {
      type: 'button-icon',
      fixedWidth: 50,
      typeAttributes: {
        iconName: 'utility:edit',
        title: 'Edit',
        variant: 'bare',
        alternativeText: 'Edit',
        name: 'edit'
      },
    },
    { label: 'Company Name', fieldName: 'Name', type: 'text', hideDefaultActions: 'false', },
    { type: 'button', typeAttributes: { label: 'View Careers', name: 'view_careers' } }
  ];

  displayInfo = {
    primaryField: 'Account.Name',
    additionalFields: ['Title'],
  };
  loadRecord(recordId) {
    console.log('hehhehe', recordId);

    AccData({ recordId: recordId })
      .then((record) => {
        this.selectedRecord = record[0]; // Assuming it returns a list, we take the first item
        console.log('Account Data: ', this.selectedRecord);
      })
      .catch((error) => {
        console.error('Error retrieving account data: ', error);
      });
  }

  handlesuccess(event) {
    console.log('i am jay patel');

    const recordId = event.detail.recordId;
    console.log('Selected Record Id: ', recordId);
    this.loadRecord(recordId);
  }



  @wire(getCompanies)
  wiredCompanies({ error, data }) {
    if (data) {
      this.companies = data.map(company => ({
        ...company,
        id: company.Id,
        Name: company.Name
      }));
    } else if (error) {
      // Handle error
    }
  }


  handleRowAction(event) {
    const actionName = event.detail.action.name;
    const row = event.detail.row;
    if (actionName === 'edit') {
      this.handleEdit(row);
    }
    if (actionName === 'view_careers') {
      window.open(row.Career_Page_URL__c, '_blank');
    }
  }

  handleEdit(row) {

    console.log('Edit action on row:', row);

    this.draftValues = [...this.draftValues, { Id: row.Id, Name: row.Name }];
    console.log(this.draftValues);


  }
  toggleSection(event) {
    const section = event.currentTarget.closest('.slds-accordion__section');
    const content = section.querySelector('.slds-accordion__content');
    const isExpanded = event.currentTarget.getAttribute('aria-expanded') === 'true';

    // Toggle aria-expanded attribute
    event.currentTarget.setAttribute('aria-expanded', !isExpanded);

    // Toggle hidden attribute
    content.hidden = isExpanded;

    // Toggle slds-is-open class
    section.classList.toggle('slds-is-open', !isExpanded);
  }
}