({
	NavigateToBeer : function(component, event, helper) {
        var eventOrigin = event.getSource();
        var id = eventOrigin.get('v.name');
        //alert(id);
        var ObjectEvent = $A.get("e.force:navigateToSObject");
        ObjectEvent.setParams({
            "recordId": id,
            "slideDevName": "detail"
        });
        ObjectEvent.fire();
	},
    ShowDetails : function(component, event, helper) {
        console.log('hey');
       var eventOrigin = event.getSource();
       var id = eventOrigin.get('v.name');
        var name = eventOrigin.get('v.value');
        //alert(name);
        $A.createComponent(
            "c:BeerDetails",
            {
                "BeerId" : id,
                "BeerName" : name,
            },
            function(beerDetails, status, errorMessage){
                //Add the new button to the body array
                if (status === "SUCCESS") {
                    component.find('overlayLib').showCustomModal({
                        header: "Beer Details",
                        body: beerDetails,
                        footer: 'Footer',
                        showCloseButton: true,
                        closeCallback: function() {
                           
                        }
           			})
                }
                else if (status === "INCOMPLETE") {
                    console.log("No response from server or client is offline.")
                    // Show offline error
                }
                else if (status === "ERROR") {
                    console.log("Error: " + errorMessage);
                    // Show error message
                }
            }
        );
      
    }
})