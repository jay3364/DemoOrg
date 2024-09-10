({
	myAction : function(component, event, helper) {
         $Lightning.use("c:task3", function() {
            $Lightning.createComponent(
                "c:task3",
                {},
                "lwcContainer"
            );
        });
		
	}
})