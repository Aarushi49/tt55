({
	onClick : function(component, event, helper) {
        //alert( component.get('v.BeerName'));
		var pagerefernceNav = component.find("navigator");
        var pageReference = {
            "type" : "standard__component",
            "attributes": {
                componentName: "c__CreateBeerOrder"
            },
            "state": {
                "c__beerId" : component.get('v.BeerId'),
                "c__beerName" : component.get('v.BeerName'),
            }
        };
       pagerefernceNav.navigate(pageReference); 
	}
})