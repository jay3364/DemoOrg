({
    Init: function(cmp, event, helper) {
        cmp.set('v.steps', [
            { label: 'Account', value: 'Account' },
            { label: 'Contact', value: 'Contact' },
            { label: 'Event', value: 'Event' }
        ]);
        cmp.set("v.currentStep", 'Account');
    },
    
    handleStepClick: function(cmp, event, helper) {
        var stepValue = event.getSource().get("v.value");
        cmp.set("v.currentStep", stepValue);
    },
    
    nextStep: function(cmp, event, helper) {
        var currentStep = cmp.get("v.currentStep");

        if (currentStep === 'Account') {
            cmp.set("v.currentStep", 'Contact');
        }
        
    },
    previousStep: function(cmp){
        var currentStep = cmp.get("v.currentStep");

        if (currentStep === 'Contact') {
            cmp.set("v.currentStep", 'Account');
        }else if(currentStep === 'Event'){
            cmp.set("v.currentStep","Contact");
        }
    },

    lastStep: function(cmp, event, helper){
        var currentStep = cmp.get('v.currentStep');
        if (currentStep === 'Contact') {
            cmp.set("v.currentStep", 'Event');
        }
    },


    SaveRecord: function(cmp, event, helper) {
        if (helper.validateEventDuration(cmp)) {
            helper.saveRecords(cmp);
        } else {
            helper.showToast("Error", "Event duration cannot exceed 14 days.", "error");
        }
    }
})