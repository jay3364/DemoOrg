({

    doInit: function (component, event, helper) {
        console.log('OUTPUT of checkListId : ', component.get("v.checkListId"));
        var SubsectionListToSelect = component.get("v.SubsectionListToSelect");
        var selectedObj = {}
        selectedObj['Id'] = 'a32Kk000000blJdIAI';
        selectedObj['Name'] = 'Excavation',
        selectedObj['Id'] = 'a32Kk000000blJYIAY';
        selectedObj['Name'] = 'Test Mv',
        selectedObj['Id'] = 'a32Kk000000blLKIAY';
        selectedObj['Name'] = 'wed test 9',

        SubsectionListToSelect.push(selectedObj);
        console.log(' SubsectionListToSelect ',JSON.parse(JSON.stringify(SubsectionListToSelect)));
        
        component.set("v.SubsectionListToSelect", SubsectionListToSelect);
    },

    closeModel: function (component, event, helper) {
        var compEvent = component.getEvent("childOrderSubsectionComponentEvent");
        compEvent.fire();
    },

    submitDetails: function (component, event, helper) {
        console.log('OUTPUT of data from parent : ', component.get("v.checkListId"));
    },
})