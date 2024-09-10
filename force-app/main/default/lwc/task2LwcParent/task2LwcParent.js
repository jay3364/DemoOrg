import { LightningElement,api } from 'lwc';

export default class task2LwcParent extends LightningElement {
     @api imageUrl;

    handleFileChange(event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = () => {
                this.imageUrl = reader.result;
            };
            reader.readAsDataURL(file);
        }
    }
}