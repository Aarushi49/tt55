({
	handleEvent : function(component, event, helper) {
        var BeerName = event.getParam('CreatEvent');
		var componentfunc = component.get('c.getBeer');
        componentfunc.setParams({
            beername : BeerName
        });
        componentfunc.setCallback(this,function(response){
            var state = response.getState();
           // alert(state);
            if(state ==="SUCCESS"){
                var response = response.getReturnValue();
                console.log(response);
                component.set('v.BeerList',response);
            }
        });
        $A.enqueueAction(componentfunc);
	}
})