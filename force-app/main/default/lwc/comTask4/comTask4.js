import { LightningElement,track} from 'lwc';
import sendResetPasswordEmail from '@salesforce/apex/ComTask3.sendResetPasswordEmail'
export default class ComTask4 extends LightningElement {
    @track username = '';
    @track showMessage = false;
    @track message = '';
    @track showError = false;
    @track errorMessage = '';

    handleUsernameChange(event) {
        this.username = event.target.value;
    }

    handleSubmit() {
        sendResetPasswordEmail({ username: this.username })
            .then(() => {
                this.message = 'An email has been sent to reset your password.';
                this.showMessage = true;
                this.showError = false;
            })
            .catch((error) => {
                this.errorMessage = 'Error processing request: ' + error.body.message;
                this.showError = true;
                this.showMessage = false;
            });
    }
}