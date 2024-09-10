({
    searchAccounts: function(component, section) {
        const searchKey = section === 1 ? component.get("v.searchKey1") : component.get("v.searchKey2");
        const action = component.get("c.searchAccounts");

        action.setParams({ searchKey: searchKey });
        action.setCallback(this, function(response) {
            const state = response.getState();
            if (state === "SUCCESS") {
                const accounts = response.getReturnValue();
                if (section === 1) {
                    component.set("v.accountsSection1", accounts);
                } else {
                    component.set("v.accountsSection2", accounts);
                }
            } else {
                console.error('Error searching accounts: ' + state);
            }
        });
        $A.enqueueAction(action);
    },
    getContacts: function(component, accountId, section) {
        const action = component.get("c.getContactsByAccountId");
        action.setParams({ accountId: accountId });
        action.setCallback(this, function(response) {
            const state = response.getState();
            if (state === "SUCCESS") {
                const result = response.getReturnValue();
                if (section == 1) {
                    component.set("v.contactsSection1", result.contacts);
                    component.set("v.contactCount1", result.contactCount);
                } else {
                    component.set("v.contactsSection2", result.contacts);
                    component.set("v.contactCount2", result.contactCount);
                }
            } else {
                console.error('Error fetching contacts: ' + state);
            }
        });
        $A.enqueueAction(action);
    },
    updateContactParent: function(component, contactId, toSection, accId) {
        const action = component.get("c.updateContactAccount");
        console.log('after class');
       
        action.setParams({
            contactId: contactId,
            accountId: accId
        });
    
        action.setCallback(this, function(response) {
            const state = response.getState();
            console.log('Response state:', state);
            if (state === "SUCCESS") {
                console.log('------success-------');
                
            } else {
                console.error('Error updating contact: ' + state);
                if (state === "INCOMPLETE") {
                    console.error('No response from server or client is offline.');
                } else if (state === "ERROR") {
                    const errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            console.error("Error message: " + errors[0].message);
                        }
                    } else {
                        console.error('Unknown error');
                    }
                }
            }
        });
        $A.enqueueAction(action);
    }

})