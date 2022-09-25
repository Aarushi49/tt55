({
    doClick : function(component, event, helper) {
     //   alert(component.isValid());
     //   alert(component.getName());
        alert(event.getSource().get('v.label'));
        var idcomponent = component.find('testid');
        alert(idcomponent.get('v.value'));
        idcomponent.set('v.value',100);
    }
})