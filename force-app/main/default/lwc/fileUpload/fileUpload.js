import { LightningElement, api } from 'lwc';
export default class fileUpload extends LightningElement {
    @api
    recordId;

    get acceptedFormats() {
        return ['.pdf', '.png', '.jpeg'];
    }

    handleUploadFinished(event) {
        // Get the list of uploaded files
        const uploadedFiles = event.detail.files;
        alert('No. of files uploaded : ' + uploadedFiles.length);
    }
}