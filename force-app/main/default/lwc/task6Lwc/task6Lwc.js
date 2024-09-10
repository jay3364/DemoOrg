import { LightningElement, track, wire } from 'lwc';
import getAllObjects from '@salesforce/apex/Task4Lwc.getAllObjects';
import searchObjects from '@salesforce/apex/Task4Lwc.searchObjects';
import objrecord from '@salesforce/apex/Task4Lwc.recordget';


export default class Task6Lwc extends LightningElement {
    @track searchTerm = '';
    @track selectedObjects = [];
    @track objectOptions = [];
    @track results = [];
    @track searchObject;
    @track inputValue;


    @wire(getAllObjects)
    wiredObjects({ error, data }) {
        if (data) {
            this.objectOptions = data.map(obj => ({
                label: obj.QualifiedApiName,
                value: obj.QualifiedApiName 
            }));
            console.log('Object Options:', this.objectOptions);
        } else if (error) {
            console.error('Error fetching objects:', error);
        }
    }

    
    columns = [
        { label: 'Name', fieldName: 'Name' }
    ];
    
    handleSearchTermChange(event) {
        this.searchTerm = event.target.value;
    }
    
    handleObjectChange(event) {
        this.selectedObjects = event.detail.value;
        console.log(this.selectedObjects);
       
    }

    handleSearch() {
        // console.log('Search term:', this.searchTerm);
        console.log('Selected objects:',JSON.stringify(this.selectedObjects));
        objrecord({ objectNames: this.selectedObjects })
                .then(data => {
                    console.log('Data:', JSON.stringify(data));
                    this.results = data.map((records, index) => ({
                        objectName: this.selectedObjects[index],
                        records: records,
                        columns: this.columns
                    }));
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        
    }

    inputget(event){
        this.inputValue = event.target.value;
    }

    searchObj(event){
        this.searchObject = event.target.value;
        console.log(this.inputValue);

        searchObjects({ searchKey: this.inputValue, selectedObjects: this.selectedObjects })
        .then(result => {
            console.log('Search result:', JSON.stringify(result));

            this.results = this.selectedObjects.map(objectName => ({
                objectName: objectName,
                records: result[objectName],
                columns: this.columns
            }));
        })
        .catch(error => {
            console.error('Error:', error);
        });
}
    


}