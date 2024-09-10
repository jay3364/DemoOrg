({

    validateEventDuration: function(cmp) {
        var eventObj = cmp.get("v.event");
        var startDate = new Date(eventObj.StartDateTime);
        var endDate = new Date(eventObj.EndDateTime);
        var duration = (endDate - startDate) / (1000 * 60 * 60 * 24); 
        if (endDate < startDate) {
            var toastEvent = $A.get("e.force:showToast");
    toastEvent.setParams({
        "title": "Error!",
        "message": "End date cannot be earlier than start date ."
    });
    toastEvent.fire();
            return { valid: false, message: "End date cannot be earlier than start date." };
        }
        return duration <= 14;
    },
    saveRecords: function(cmp) {
        var account = cmp.get("v.account");
        var contact = cmp.get("v.contact");
        var eventObj = cmp.get("v.event");

        var action = cmp.get("c.createRecords");
        action.setParams({
            "account": account,
            "contact": contact,
            "eventObj": eventObj
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                cmp.set("v.lastCreatedAccountId", result.AccountId);
                cmp.set("v.lastCreatedContactId", result.ContactId);
                
                this.showToast("Success", "Records created successfully", "success");
            } else if (state === "ERROR") {
                var errors = response.getError();
                console.error('Error creating records:', errors);
            } else {
                console.log('Unknown problem, state:', state);
            }
        });
        $A.enqueueAction(action);
    },

    showToast: function(title, message, type) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": title,
            "message": message,
            "type": type
        });
        toastEvent.fire();
    }
})