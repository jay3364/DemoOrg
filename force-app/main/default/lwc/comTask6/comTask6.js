import { LightningElement } from 'lwc';

export default class ComTask6 extends LightningElement {
    navigateHome() {
        window.location.href = '/';
    }

    navigateProfile() {
        window.location.href = '/profile';
    }

    navigateLogout() {
        window.location.href = '/secur/logout.jsp';
    }
}