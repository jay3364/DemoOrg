import { LightningElement } from 'lwc';
import salesforceLogo from '@salesforce/resourceUrl/AI_associate';
import profilePhoto from '@salesforce/resourceUrl/EyeIcon';
export default class Portfolio extends LightningElement {
    salesforceLogo = salesforceLogo;
    profilePhoto = profilePhoto;
    
    downloadResume(){
        console.log('Download Resume');
        const staticResources =     [
                {
                    name: 'Resume',
                    url: 'https://github.com/JaykumarPatel/JaykumarPatel/raw/master/Resume.pdf'
                }
            ]
    }
    }

