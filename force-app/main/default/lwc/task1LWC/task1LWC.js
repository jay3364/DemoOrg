import { LightningElement} from 'lwc';
import createContact from '@salesforce/apex/Task1LWC.insertContact';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class Task1LWC extends LightningElement {
    LastName='';
    FirstName='';
    Salutate = '';
    Email = '';
    handleClick() {
        try {
            const lastName = this.template.querySelector('.lastName').value;
            const firstName = this.template.querySelector('.firstName').value;
            const salutate = this.template.querySelector('.salutate').value;
            const email = this.template.querySelector('.email').value;

            const contact = {
                LastName : lastName,
                FirstName : firstName,
                Salutate : salutate,
                Email : email
            }

            createContact({contact}).then(
                result =>{
                    this.dispatchEvent(new ShowToastEvent({
                        title: "SUCCESS",
                        message: "Record Save with "+contact.id,
                        variant: "success"
                    }));
                    try {
                        this.clearForm();
                    } catch (error) {
                        console.log(JSON.stringify(error));
                    }

            })

            .catch(error=>{
                console.error(error);
            })
            
            console.log('Last Name:', lastName);
            console.log('First Name:', firstName);
            console.log('Salutation:', salutate);
            console.log('Email:', email);
        } catch (error) {
            console.error('Error:', error);
        }
    }
    clearForm() {
        this.lastName = '';
        this.firstName = '';
        this.salutate = '';
        this.email = '';
        this.template.querySelectorAll('lightning-input').forEach(input => {
            input.value = '';
        });
    }
}