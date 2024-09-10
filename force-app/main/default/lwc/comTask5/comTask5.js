import { LightningElement } from 'lwc';
import IMAGE_URL from '@salesforce/resourceUrl/error';
export default class ComTask5 extends LightningElement {
    imageUrl = IMAGE_URL;
    handleGoHome() {
        window.location.href = '/';
    }
}