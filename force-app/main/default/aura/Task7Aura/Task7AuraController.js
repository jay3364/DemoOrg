({
    doInit : function(component, event, helper) {
        var action = component.get("c.getAccountData");
        console.log('this is the action',action);
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('state',state);
            if (state === "SUCCESS") {
                console.log('initiate condition');
                component.set("v.accountWrappers", response.getReturnValue());
                console.log('response.getReturnValue()',response.getReturnValue());
            } else {
                component.set("v.errorMessage", 'Error: ' + response.getError()[0].message);
            }
        });
        $A.enqueueAction(action);
    }
})