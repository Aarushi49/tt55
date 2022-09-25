({
    processMessage : function(component) {
        window.addEventListener('load', function() {
            sforce.opencti.onClickToDial({listener: listener});
        });
        
        var listener = function(payload) {
            var utilityAPI = component.find("utilitybar");
            utilityAPI.openUtility({utilityAPI});
            console.log('Clicked phone number: ' + payload.number);
            console.log('Concerned record: ' + payload.recordId);
            
            var componentfunc = component.get('c.getAcc');
            componentfunc.setParams({
                accId : payload.recordId
            });
            componentfunc.setCallback(this,function(response){
                var state = response.getState();
                console.log(state);
                if(state ==="SUCCESS"){
                    var response = response.getReturnValue();
                    console.log(response);
                    component.set('v.accSearchKey',response);
                }
            });
            $A.enqueueAction(componentfunc);
            component.set('v.acctId',payload.recordId);
        };
        
    }
    
})