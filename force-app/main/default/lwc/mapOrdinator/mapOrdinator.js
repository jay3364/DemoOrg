import { LightningElement,track } from 'lwc';
import getCoordinatesFromAddress from '@salesforce/apex/GeolocationService.getCoordinatesFromAddress';

export default class GetLocationComponent extends LightningElement {

    @track address = '';
    @track latitude;
    @track longitude;
    @track coordinatesAvailable = false;

    handleAddressChange(event) {
        this.address = event.target.value;
    }

    handleGetCoordinates() {
        if (this.address) {
            getCoordinatesFromAddress({ address: this.address })
                .then((result) => {
                    if (result) {
                        this.latitude = result.latitude;
                        this.longitude = result.longitude;
                        this.coordinatesAvailable = true;
                    }
                })
                .catch((error) => {
                    console.error('Error fetching coordinates:', error);
                    this.coordinatesAvailable = false;
                });
        }
    }
}

