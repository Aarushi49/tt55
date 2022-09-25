({
    doinit : function(component, event, helper) {
        var action = component.get('c.getContact');
        action.setParams({
            accountid : component.get('v.recordId'),
        });
        action.setCallback(this,function(response){
            var responselist = response.getReturnValue();
            console.log('total contacts are here --'+responselist);
            component.set('v.contactList',responselist);
        },'SUCCESS');
        $A.enqueueAction(action,false);
    },
    doRedirect : function(component, event, helper) {
        var eventSource = event.getSource();
        var id = eventSource.get('v.name');
        alert(id);
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": id,
            "slideDevName": "detail"
        });
        navEvt.fire();
    },
    handleEvent : function(component, event, helper) {
    var ContactCreated = event.getParam('ContactListEvent');
    var componentlist = component.get('v.contactList');
    componentlist.push(ContactCreated);
    component.set('v.contactList',componentlist);
    }
})