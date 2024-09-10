({

    // handleClick : function(component, event, helper) {
    //     var compEvent = component.getEvent("sampleComponentEvent");
    //     compEvent.setParams({
    //         "message" : component.get("v.enteredText") 
    //     });
    //     compEvent.fire();
    // }

    
        handleFileChange : function(component, event, helper) {
            try {
            console.log('event',event);
            console.log('event source', event.target);
            var fileInput = event.target;
            console.log('this is the evnt after file input');
            var file = fileInput.files[0];
            var reader = new FileReader();
            
            reader.onload = function(e) {
                var fileContent = e.target.result;
                var compEvent = component.getEvent("sampleComponentEvent");
                console.log('compEvent',compEvent);
                compEvent.setParams({
                    "message": fileContent
                });
                console.log('after set compoEvent',compEvent);
                compEvent.fire();
            };
            
            reader.readAsDataURL(file);
        }catch (error) {
            console.log('this is the error'+error);
        }
    } 

        
    
    // handleFileChange: function(component, event, helper) {
    //     var fileInput = component.find("fileUpload").getElement();
    //     var file = fileInput.files[0];
        
    //     // Emit event with file data
    //     var fileReader = new FileReader();
    //     fileReader.onload = function() {
    //         var fileContents = fileReader.result;
    //         var base64 = 'data:image/png;base64,' + btoa(fileContents);
    //         var fileData = {
    //             name: file.name,
    //             type: file.type,
    //             base64: base64
    //         };
    //         var fileChangeEvent = component.getEvent("fileChange");
    //         fileChangeEvent.setParams({ "fileData": fileData });
    //         console.log('fileChangeEvent',fileChangeEvent);
    //         fileChangeEvent.fire();
    //     };
    //     fileReader.readAsBinaryString(file);
    // }
})