import { LightningElement, track } from 'lwc';
import requiredField from '@salesforce/apex/Required_field.getRequiredFields';
export default class RequeredFields extends LightningElement {

    @track valueInput;
    @track requiredFields
    apexFunction(){
        requiredField({objectName : this.valueInput}).then(result =>{
            this.requiredFields = result;
            console.log(JSON.stringify(this.requiredFields));
        })
    }

    handleClick(){
       
        const inputElement = this.template.querySelector('[data-id="objectId"]');
        
        this.valueInput = inputElement.value;
        
        console.log(this.valueInput);
        this.apexFunction();
    }
}