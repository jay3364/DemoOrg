import { LightningElement, track } from 'lwc';
import searchObjects from '@salesforce/apex/Task4Lwc.searchObjects';

export default class Test6Lwc extends LightningElement {
    @track showDropdown = false;
    @track selectionlimit = 10;
    @track searchTerm = '';
    @track filteredResults = [];
    @track searchInput;

    inputvalue(event){
        this.searchInput = event.target.value;
    }
    handleSearch() {
        console.log('handleSearch called'); 
        
        // this.searchInput = this.template.querySelector('lightning-input[name="enter-search"]');
        console.log('Search Input Element:', this.searchInput); 

        if (this.searchInput) {
            this.searchTerm = this.searchInput;
            console.log('Search Term:', this.searchTerm); 

            if (this.searchTerm.length > 1) {
                searchObjects({ searchKey: this.searchTerm })
                    .then(data => {
                        console.log('data==>', JSON.stringify(data));
                        this.filteredResults = data.flat().map(item => ({
                            Id: item.Id,
                            Name: item.Name,
                            isChecked: false
                        }));
                        this.showDropdown = true;
                        console.log(this.showDropdown);
                    })
                    .catch(error => {
                        console.error('Error fetching data:', error);
                    });
            } else {
                this.showDropdown = false;
                this.filteredResults = [];
            }
        } else {
            console.error('Search input element not found');
        }
    }

    handleSelection(event) {
        const selectedId = event.target.value;

        this.filteredResults = this.filteredResults.map(item => ({
            ...item,
            isChecked: item.Id === selectedId ? !item.isChecked : item.isChecked
        }));

        const selectedItemsCount = this.filteredResults.filter(item => item.isChecked).length;
        if (selectedItemsCount >= this.selectionlimit) {
            this.showDropdown = false;
        }
    }
}