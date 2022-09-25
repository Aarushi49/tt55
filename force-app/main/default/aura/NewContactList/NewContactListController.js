({
	doinit : function(component, event, helper) {
		var action = component.get("c.getContacts");
        console.log(component.get('v.recordId'));
        action.setParams({
            accountId : component.get('v.recordId'),
        });
        action.setCallback(this,function(response){
            var response = response.getReturnValue();
            console.log(response);
            component.set("v.ContactList",response);
        });
        $A.enqueueAction(action);
	},
    
   onClick : function(component, event, helper) {
        var eventorigin = event.getSource();
        var id = eventorigin.get('v.name');
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
          "recordId": id,
          "slideDevName": "detail"
        });
        navEvt.fire();
     },
    
    handleEvent : function(component, event, helper) {
        var contactCreated = event.getParam("CreatEvent");
        var contactList = component.get('v.ContactList');
        contactList.push(contactCreated);
        component.set("v.ContactList",contactList);
    }

})