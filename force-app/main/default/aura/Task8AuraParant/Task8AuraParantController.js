({
    init: function(component, event, helper) {
        
    //     var fileChangeHandler = $A.getCallback(function(fileData) {
    //         component.set("v.uploadedImage", fileData);
    //     });
    //     component.addHandler("fileChange", fileChangeHandler);
    },
    handleComponentEvent : function(component, event, helper) {
        var valueFromChild = event.getParam("message");
        console.log('Value from child: ', valueFromChild);
        component.set("v.uploadedImage", valueFromChild);
    }
})