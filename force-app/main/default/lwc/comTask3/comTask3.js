import { LightningElement, track } from 'lwc';
import sendForgotPasswordEmail from '@salesforce/apex/ComTask3.sendForgotPasswordEmail';
import { NavigationMixin } from 'lightning/navigation';
export default class ComTask3 extends NavigationMixin(LightningElement)  {
    @track username = '';
    @track showMessage = false;
    @track message = '';
    @track showError = false;
    @track errorMessage = '';

    handleUsernameChange(event) {
        this.username = event.target.value;
    }

    handleSubmit() {
        console.log(this.username);
        sendForgotPasswordEmail({ username: this.username })
            .then((result) => {
                console.log('result',result);
                this.message = 'An email has been sent to reset your password.';
                this.showMessage = true;
                this.showError = false;
                console.log(this.message);
            })
            .catch((error) => {
                console.error('error',JSON.stringify(error));
                this.errorMessage = 'Username not found.';
                this.showError = true;
                this.showMessage = false;
            });
    }

    handleClick(){
        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                url: '/loginpage/reset-password'
            }
        }).catch(error => {
            console.error(JSON.stringify(error));
        });
    }
}