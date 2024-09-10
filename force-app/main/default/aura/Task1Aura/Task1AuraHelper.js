({
    saveContact: function(component) {
        var newContact = component.get("v.newContact");
        console.log("New Contact:", newContact);

        var action = component.get("c.saveContactRecord");
        console.log("Action:", action);
        action.setParams({
            "contact": newContact
        });

        if (!action) {
            console.error("Action 'saveContactRecord' not found");
            return;
        }

        component.set("v.newContact", {
            'sobjectType': 'Contact',
            'FirstName': '',
            'LastName': '',
            'Phone': '',
            'Email': ''
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                
                console.log('start toast');
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Success',
                    type : 'Success',
                    message: 'This is an information message.',
                    
                });
                toastEvent.fire();
                console.log('this is toast');
                
            } else {
                var errors = response.getError();
                if (errors && errors[0] && errors[0].message) {
                    console.error("Error message: " + errors[0].message);
                } else {
                    console.error("Unknown error");
                }
            }
        });

        

       
        $A.enqueueAction(action);
    }
})