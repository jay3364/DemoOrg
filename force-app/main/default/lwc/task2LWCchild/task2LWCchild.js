import { LightningElement, api } from 'lwc';

export default class Task2LwcChild extends LightningElement {
    @api imageUrl;
    // columns = [
    //     { label: 'Name', fieldName: 'name' }, 
    //     { label: 'Type', fieldName: 'type' }, 
    //     { label: 'Size', fieldName: 'size' },
    //     {
    //         label: 'Image',
    //         fieldName: 'imageUrl',
    //         type: 'image',
    //         typeAttributes: { alt: { fieldName: 'name' }, width: '100px', height: '100px' },
    //     },
    //     { label: 'ContantVersion', fieldName: 'contentVersion'}
    // ];

    // get dataTable() {
    //     console.log('this is the');
    //     if (this.getValue && this.getValue.length > 0) {
    //         return this.getValue.map(file => ({
    //             id: file.documentId,
    //             name: file.name,
    //             type: file.type,
    //             size: file.size,
    //             imageUrl: file.type.startsWith('image/') ? '/sfc/servlet.shepherd/version/download/' + file.documentId : '',
    //             contentVersion : file.contentVersion
    //         }));
    //     }
    //     return [];
    // }
}