({
    doInit: function(component, event, helper) {
       
    },
    handleSearch1: function(component, event, helper) {
        const searchKey1 = component.get("v.searchKey1");
        if (!searchKey1) {
            component.set("v.accountsSection1", []);
            component.set("v.contactsSection1", []);
            component.set("v.contactCount1", 0);
        } else {
            helper.searchAccounts(component, 1);
        }
    },
    handleSearch2: function(component, event, helper) {
        const searchKey2 = component.get("v.searchKey2");
        if (!searchKey2) {
            component.set("v.accountsSection2", []);
            component.set("v.contactsSection2", []);
            component.set("v.contactCount2", 0);
        } else {
            helper.searchAccounts(component, 2);
        }
    },

    getContact: function(component, event, helper) {
        const accountId = event.getSource().get("v.value");
        const section = event.getSource().getElement().closest('.section1') ? 1 : 2;
        helper.getContacts(component, accountId, section);
        console.log(accountId);
        console.log(section);
        if(section == 1){
            console.log('section1',accountId);
            component.set('v.toAccountId1',accountId);
            console.log('v.toAccountId1', component.get('v.toAccountId1'));
        }
        else if(section == 2){
            console.log('section2',accountId);
            component.set('v.toAccountId2',accountId);
            console.log('v.toAccountId2', component.get('v.toAccountId2'));
        }

        
    },
    handleDragStart: function(component, event, helper) {
        event.dataTransfer.setData("contactId", event.target.dataset.contactid);
        event.dataTransfer.setData("section", event.target.closest('.section').dataset.section);
        console.log('Drag started for contactId:', event.target.dataset.contactid);
        console.log('Drag started from section:', event.target.closest('.section').dataset.section);
    },
    handleDrop: function(component, event, helper) {
        const contactId = event.dataTransfer.getData("contactId");
        const fromSection = event.dataTransfer.getData("section");
        const toSection = event.target.closest('.section').getAttribute('data-section');
       
        console.log('From Section: ' + fromSection);
        console.log('To Section: ' + toSection);
        console.log('Contact ID: ' + contactId);

        if (fromSection !== toSection) {
            console.log('now call the function ');
            if(toSection == 1){
                helper.updateContactParent(component, contactId, toSection, component.get('v.toAccountId1'));
                
            }
            else if(toSection == 2){
                helper.updateContactParent(component, contactId, toSection, component.get('v.toAccountId2'));
            }

            console.log('success');
            console.log('component.get(v.toAccountId1)',component.get('v.toAccountId1'));
            console.log('component.get(v.toAccountId2)',component.get('v.toAccountId2'));
            console.log('fromSection',fromSection);
            console.log('toSection',toSection);
            helper.getContacts(component, component.get('v.toAccountId1'), fromSection);
            helper.getContacts(component, component.get('v.toAccountId2'), toSection);
            
        }
    },
    handleDragOver: function(component, event, helper) {
        event.preventDefault();
       
    }
})