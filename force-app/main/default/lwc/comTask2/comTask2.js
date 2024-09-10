import { LightningElement, track } from 'lwc';
import loginUser from '@salesforce/apex/com1Registration.authenticateUser';
//import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

export default class ComTask2 extends NavigationMixin(LightningElement) {
    @track selectedUserType = 'Teacher'; 
    @track username = '';   
    @track password = '';

    userTypeOptions = [
        { label: 'Teacher', value: 'Teacher' },
        { label: 'Student', value: 'Student' },
        { label: 'Standard', value: 'Standard' }
    ];

    handleUserTypeChange(event) {
        this.selectedUserType = event.detail.value;
    }

    forgetPassword(){
        console.log(window.location.href);
        window.location.href = '/loginpage/forgetpassword';
    }

    handleInputChange(event) {
        const field = event.target.dataset.id;
        if (field === 'username') {
            this.username = event.target.value;
        } else if (field === 'password') {
            this.password = event.target.value;
        }
    }

    handleLogin() {
        console.log(this.username,' ',this.password, ' ',this.selectedUserType);
        
        loginUser({ 
            username: this.username, 
            password: this.password, 
            userType: this.selectedUserType 
        })
        .then(result => {
            console.log(result);
            if (result.success) {
               
                if (this.selectedUserType === 'Teacher' || 'Standard') {
                    window.location.href = '/loginpage/teacherhomepage';
                } else {
                    window.location.href = '/studentHomePage';
                }
            } else {
              
                alert('Login failed: ' + result.message);
            }
        })
        .catch(error => {
           
            console.error('Error during login:', error);
            alert('An unexpected error occurred. Please try again.');
        });
    }
}