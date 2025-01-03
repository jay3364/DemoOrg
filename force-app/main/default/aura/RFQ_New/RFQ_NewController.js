({
    doInit: function (component, event, helper) {
        var value = helper.getParameterByName(component, event, 'inContextOfRef');
        var context = '';
        var parentRecordId = '';
        component.set("v.parentRecordId", parentRecordId);
        if (value != null) {
            context = JSON.parse(window.atob(value));
            parentRecordId = context.attributes.recordId;
            console.log(context);
            console.log(parentRecordId);
            // component.set("v.parentRecordId", parentRecordId);
        } else {
            var relatedList = window.location.pathname;
            var stringList = relatedList.split("/");
            parentRecordId = stringList[4];
            if (parentRecordId == 'related') {
                var stringList = relatedList.split("/");
                parentRecordId = stringList[3];
            }

            // component.set("v.parentRecordId", parentRecordId);
        }
        if(parentRecordId != null && parentRecordId != ''){
            var action = component.get("c.getobjectName");
            action.setParams({
                recordId: parentRecordId,
            });
            action.setCallback(this, function (response) {
                if (response.getState() == 'SUCCESS' && response.getReturnValue()) {
                    var objName = response.getReturnValue();
                    console.log('objName---->',objName);
                    if(objName == 'buildertek__Project__c'){
                        component.set("v.parentprojectRecordId", parentRecordId);
                    } else if(objName == 'Opportunity') {
                        component.set("v.oppRecordId", parentRecordId);
                    }
                } 
            });
            $A.enqueueAction(action);
        }
        helper.getFields(component, event, helper);
        console.log('doInit parentRecordId: ' + parentRecordId);
    },

    closeModel: function (component, event, helper) {
       var workspaceAPI = component.find("workspace");
        // workspaceAPI.getAllTabInfo().then(function (response) {
        //     console.log(response);
        //     debugger;
        // }).catch(function (error) {
        //     console.log(error);
        // });
        workspaceAPI.getFocusedTabInfo().then(function (response) {
                var focusedTabId = response.tabId;
                workspaceAPI.closeTab({
                    tabId: focusedTabId
                });
            })
            .catch(function (error) {
                console.log(error);
            });
      /*  $A.get("e.force:closeQuickAction").fire();
        window.setTimeout(
            $A.getCallback(function () {
                $A.get('e.force:refreshView').fire();
            }), 1000
        );*/
        var action = component.get("c.getListView");
    action.setCallback(this, function(response){
        var state = response.getState();
        if (state === "SUCCESS") {
            var listviews = response.getReturnValue();
            var navEvent = $A.get("e.force:navigateToList");
            navEvent.setParams({
                "listViewId": listviews.Id,
                "listViewName": null,
                "scope": "buildertek__RFQ__c"
            });
            navEvent.fire();
        }
    });
    $A.enqueueAction(action);
    },
        /* gotoList : function (component, event, helper) {
    var action = component.get("c.getListView");
    action.setCallback(this, function(response){
        var state = response.getState();
        if (state === "SUCCESS") {
            var listviews = response.getReturnValue();
            var navEvent = $A.get("e.force:navigateToList");
            navEvent.setParams({
                "listViewId": listviews.Id,
                "listViewName": null,
                "scope": "buildertek__RFQ__c"
            });
            navEvent.fire();
        }
    });
    $A.enqueueAction(action);
},*/


    handleSubmit: function (component, event, helper) {
        try{
        // debugger;
        component.set('v.isLoading', true);
        var fields = event.getParam("fields");
        fields.buildertek__Status__c = component.get("v.status"); 
        console.log({fields});
        event.preventDefault(); // Prevent default submit
        component.find('recordViewForm').submit(fields); // Submit form
        }catch(e){
            console.log({e});
        }
    },

    onRecordSuccess: function (component, event, helper) {
        console.log('onRecordSuccess');
         component.set('v.isLoading', true);
        var workspaceAPI = component.find("workspace");
        workspaceAPI.getFocusedTabInfo().then(function (response) {
            var focusedTabId = response.tabId;
            workspaceAPI.closeTab({
                tabId: focusedTabId
            });
        }).catch(function (error) {
            console.log('Error', JSON.stringify(error));
        });
        setTimeout(function () {
           
            var payload = event.getParams().response;
            var url = location.href;
            var baseURL = url.substring(0, url.indexOf('/', 14));
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                mode: 'sticky',
                message: 'RFQ created successfully',
                messageTemplate: "RFQ created successfully.",
                messageTemplateData: [{
                    url: baseURL + '/lightning/r/buildertek__RFQ__c/' + escape(payload.id) + '/view',
                    label: payload.name,
                }],
                type: 'success',
                duration: '10000',
                mode: 'dismissible'
            });
            toastEvent.fire();
 
            var navEvt = $A.get("e.force:navigateToSObject");
            navEvt.setParams({
                "recordId": payload.id,
                "slideDevName": "related"
            });
            navEvt.fire();
        }, 200);
        component.set('v.isLoading', false);
    },

    saveAndNew: function (component, event, helper) {
        debugger;
        
          var Name = component.get("v.rfqName");
       // alert(Name);
         if(Name != null){
             //alert("hai");
        component.set('v.isLoading', true);
        event.preventDefault(); // Prevent default submit
        var fields = event.getParam("listOfFields");
        component.find('recordViewForm').submit(fields); // Submit form
             
         var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                         title: 'SUCCESS',
                        message: 'RFQ created successfully.',
                        type : 'success',
                        duration: '5000',
                        mode: 'dismissible'
                    });
                    toastEvent.fire();
        
        $A.get('e.force:refreshView').fire();
              }
        else{
                  var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title: 'ERROR',
                        message: 'Please Enter the RFQ Description.',
                        duration: "5000",
                        key: "info_alt",
                        type: "error",
                        mode: "pester",
                    });
                    toastEvent.fire();
             }
      

       
       
    }
})