import { LightningElement, track } from 'lwc';
import uploadToDropbox from '@salesforce/apex/dropBox.uploadToDropbox';
import fetchDropboxFiles from '@salesforce/apex/dropBox.fetchDropboxFiles';
import deleteFromDropbox from '@salesforce/apex/dropBox.deleteFromDropbox';

export default class DropboxIntegration extends LightningElement {
    @track files = [];
    @track isUploadDisabled = true;
    fileName;
    fileContents;

    handleFileChange(event) {
        const file = event.target.files[0];
        this.fileName = file.name;
        const reader = new FileReader();

        reader.onload = () => {
            this.fileContents = reader.result.split(',')[1];
            this.isUploadDisabled = false;
        };

        reader.readAsDataURL(file);
    }

    uploadFile() {
        if (this.fileContents) {
            uploadToDropbox({ fileName: this.fileName, fileBodyBase64: this.fileContents })
                .then(() => {
                    this.fetchFiles();  
                })
                .catch(error => {
                    console.error('Error uploading file:', error);
                });
        } else {
            console.error('File contents are empty');
        }
    }

    fetchFiles() {
        fetchDropboxFiles()
            .then(result => {
                this.files = result;
            })
            .catch(error => {
                console.error('Error fetching files:', error);
            });
    }

    handleDelete(event) {
        const fileId = event.target.dataset.id;
        console.log(fileId);
        deleteFromDropbox({ fileId })
            .then(() => {
                this.fetchFiles();  
            })
            .catch(error => {
                console.error('Error deleting file:', error);
            });
    }
}