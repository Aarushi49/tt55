({
	searchBeer : function(component, event, helper) {
        var searchInput = component.find('searchInput').get('v.value');
        //alert(searchInput);
		var eventComp = component.getEvent('BeerName');
        eventComp.setParams({
            CreatEvent : searchInput
        });
        eventComp.fire();
	}
})