({
    CreateNewContact : function(component, event, helper) {
        var action = component.get('c.insertContact');	
        action.setParams({
            con: component.get('v.NewContact'),
            AccountId : component.get('v.IdAccount')
        });
        action.setCallback(this,function(response){
            var id = response.getReturnValue();
            var componentEvent = component.getEvent('ListEvent');
            componentEvent.setParams({
                ContactListEvent : id
            });
            componentEvent.fire();
        },'ALL');
        $A.enqueueAction(action,false);
    }
})