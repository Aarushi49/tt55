({
	CreateContact : function(component, event, helper) {
		var action = component.get('c.insertcontact');
        action.setParams({
            con : component.get('v.Createcontact'),
            Accountid : component.get('v.Accountid')
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            alert(state);
            if(state == 'SUCCESS' ){
                var response = response.getReturnValue();
                
                /* 	var navEvt = $A.get("e.force:navigateToSObject");
                    navEvt.setParams({
                          "recordId": response,
                          "slideDevName": "detail"
                        });
                	navEvt.fire(); */
                
                var event = component.getEvent("createQuickEvent");
                event.setParams({
                    CreatEvent : response
                });
                event.fire();
            }else{
                console.log(response.getError());
            }
            
        });
        $A.enqueueAction(action);
	}
})