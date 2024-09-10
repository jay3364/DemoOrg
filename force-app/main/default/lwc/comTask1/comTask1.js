import { LightningElement, track } from 'lwc';
import createCommunityUser from '@salesforce/apex/com1Registration.createCommunityUser';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

export default class RegistrationForm extends NavigationMixin(LightningElement) {
    @track selectedRole;
    @track teacherName = '';
    @track teacherEmail = '';
    @track studentName = '';
    @track studentEmail = '';
    @track accountId = '';

    get roleOptions() {
        return [
            { label: 'Teacher', value: 'Teacher' },
            { label: 'Student', value: 'Student' }
        ];
    }

    get isTeacher() {
        return this.selectedRole === 'Teacher';
    }

    get isStudent() {
        return this.selectedRole === 'Student';
    }

    handleRoleChange(event) {
        this.selectedRole = event.detail.value;
    }

    handleInputChange(event) {
        const field = event.target.name;
        console.log('field==>',field);
        
        if (field === 'teacherName') {
            this.teacherName = event.target.value;
        } else if (field === 'teacherEmail') {
            this.teacherEmail = event.target.value;
        } else if (field === 'studentName') {
            this.studentName = event.target.value;
        } else if (field === 'studentEmail') {
            this.studentEmail = event.target.value;
        }
    }

    handleRegister() {
        const userData = {
            role: this.selectedRole,
            teacherName: this.teacherName,
            teacherEmail: this.teacherEmail,
            studentName: this.studentName,
            studentEmail: this.studentEmail,
            accountId: this.accountId
        };

        createCommunityUser({ userData })
            .then(result => {
                this.showToast('Success', 'User registered successfully', 'success');
                this.handleRedirect();
            })
            .catch(error => {
                this.showToast('Error', error.body.message, 'error');
            });
    }

    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title,
            message,
            variant
        });
        this.dispatchEvent(event);
    }

    handleRedirect() {
        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                url: '/loginpage'
            }
        });
    }
}