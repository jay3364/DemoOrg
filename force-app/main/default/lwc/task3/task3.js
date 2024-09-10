import { LightningElement, api, track, wire } from 'lwc';
import getContentDetails from '@salesforce/apex/FileUploder.getContentDetails';

export default class FileUploadComponent extends LightningElement {
    @api recordId;
    @track uploadedFiles = [];
    @track currentPage = 1;
    filesPerPage = 5;

    get acceptedFormats() {
        return ['.jpg', '.jpeg', '.png', '.pdf'];
    }

    connectedCallback() {
        this.fetchFiles();
    }

    @wire(getContentDetails, { recordId: '$recordId' })
    wiredFiles({ error, data }) {
        if (data) {
            this.uploadedFiles = JSON.parse(data).map(file => ({
                id: file.ContentDocumentId,
                name: file.Title,
                size: file.ContentDocument.ContentSize,
                previewUrl: `/sfc/servlet.shepherd/version/download/${file.Id}`,
                // downloadUrl: `/sfc/servlet.shepherd/document/download/${file.ContentDocumentId}`
            }));
        } else if (error) {
            console.error('Error fetching files:', error);
        }
    }

    get displayedItems() {
        const start = (this.currentPage - 1) * this.filesPerPage;
        const end = start + this.filesPerPage;
        return this.uploadedFiles.slice(start, end);
    }

    get totalPages() {
        return Math.ceil(this.uploadedFiles.length / this.filesPerPage);
    }

    get isFirstPage() {
        return this.currentPage === 1;
    }

    get isLastPage() {
        return this.currentPage === this.totalPages;
    }

    handleUploadFinished(event) {
        const uploadedFiles = event.detail.files;
        console.log(JSON.stringify(uploadedFiles));
        this.fetchFiles();
    }

    fetchFiles() {
        getContentDetails({ recordId: this.recordId })
            .then(result => {
                this.uploadedFiles = JSON.parse(result).map(file => ({
                    id: file.ContentDocumentId,
                    name: file.Title,
                    size: file.ContentDocument.ContentSize,
                    previewUrl: `/sfc/servlet.shepherd/version/renditionDownload?rendition=THUMB720BY480&versionId=${file.Id}`,
                    // downloadUrl: `/sfc/servlet.shepherd/document/download/${file.ContentDocumentId}`
                }));
                this.updateDisplayedItems();
            })
            .catch(error => {
                console.error('Error fetching files:', error);
            });
    }

    updateDisplayedItems() {
        this.currentPage = 1;
    }

    previousPage() {
        if (this.currentPage > 1) {
            this.currentPage--;
        }
    }

    nextPage() {
        if (this.currentPage < this.totalPages) {
            this.currentPage++;
        }
    }
}