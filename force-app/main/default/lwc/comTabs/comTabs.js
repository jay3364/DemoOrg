import { LightningElement, wire, track } from 'lwc';
import getTeacherDetails from '@salesforce/apex/TeacherController.getTeacherDetails';
import getStudents from '@salesforce/apex/StudentController.getStudents';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import starIcon from '@salesforce/resourceUrl/Rating_Star';
import saveFeedback from '@salesforce/apex/StudentController.saveFeedback';

export default class comTabs extends LightningElement {
    @track teacher;
    @track students;
    @track isEditing = false;
    starIcon = starIcon;

    @wire(getTeacherDetails)
    wiredTeacher({ error, data }) {
        if (data) {
            this.teacher = data;
            this.teacherId = data.Id;
            this.getStudentsForTeacher();
        } else if (error) {
            this.showToast('Error', error.body.message, 'error');
        }
    }

    getStudentsForTeacher() {
        getStudents({ teacherId: this.teacherId })
            .then((data) => {
                this.students = data;
            })
            .catch((error) => {
                this.showToast('Error', error.body.message, 'error');
            });
    }

    handleEdit() {
        this.isEditing = true;
    }

    handleSave() {
        const fields = {};
        fields['Id'] = this.teacherId;
        fields['Name'] = this.template.querySelector("[data-id='name']").value;
        fields['Email__c'] = this.template.querySelector("[data-id='email']").value;

        const recordInput = { fields };
        updateRecord(recordInput)
            .then(() => {
                this.showToast('Success', 'Teacher updated successfully', 'success');
                this.isEditing = false;
            })
            .catch((error) => {
                this.showToast('Error', error.body.message, 'error');
            });
    }

    handleCancel() {
        this.isEditing = false;
    }

    handleStudentClick(event) {
        const studentId = event.target.dataset.id;
        // Implement navigation to Student detail page
    }

    handleRating(event) {
        const studentId = event.target.dataset.id;
        const rating = event.target.dataset.rating;
        const feedback = {
            Student__c: studentId,
            Rating__c: rating,
            Teacher__c: this.teacherId
        };

        saveFeedback({ feedback })
            .then(() => {
                this.showToast('Success', 'Feedback submitted successfully', 'success');
                this.updateStarClass(studentId, rating);
            })
            .catch((error) => {
                this.showToast('Error', error.body.message, 'error');
            });
    }

    getStarClass(studentId, star) {
        // Implement logic to return the appropriate CSS class based on the current rating
        // For now, just return 'star-icon'
        return 'star-icon';
    }

    updateStarClass(studentId, rating) {
        // Implement logic to update the CSS class for the stars based on the new rating
    }

    showToast(title, message, variant) {
        const event = new ShowToastEvent({ title, message, variant });
        this.dispatchEvent(event);
    }
}