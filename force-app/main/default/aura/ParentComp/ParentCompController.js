({
	TryButton : function(component, event, helper) {
		var getComp = component.find('Childid');
        getComp.ChildFunc('FRom Parent Component');
	},
    CheckOnClick : function(component, event, helper) {
     alert('hey');
    }
})