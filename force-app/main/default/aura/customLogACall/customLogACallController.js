({
    doInit : function(component,event,helper) {    
        //alert(component.get('v.acctId'));
        var componentfunc = component.get('c.getAcc');
        componentfunc.setParams({
            accId : component.get('v.acctId')
        });
        componentfunc.setCallback(this,function(response){
            var state = response.getState();
            console.log(state);
            //alert(state);
            if(state ==="SUCCESS"){
                var response = response.getReturnValue();
                console.log(response);
                component.set('v.accSearchKey',response);
            }else if(state ==="ERROR"){
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                    errors[0].message);
                    }
                }     
            }
        });
        $A.enqueueAction(componentfunc);
    },
    
	 handleClick : function(component, event, helper) {
        var componentfunc = component.get('c.createTask');
        componentfunc.setParams({
            accId : component.get('v.acctId'),
            subject : component.get('v.subject'),
            comments : component.get('v.comments'),
            notes : component.get('v.notes'),
            conId : component.get('v.contactId')
        });
        
        componentfunc.setCallback(this,function(response){
            var state = response.getState();
            console.log(state);
            if(state ==="SUCCESS"){
                	component.set('v.acctId',''),
                    component.set('v.subject',''),
                    component.set('v.comments',''),
                    component.set('v.notes',''),
                    component.set('v.contactId',''),
                    component.set('v.accSearchKey',''),
                    component.set('v.SearchKey','')
            }
            
        });
        $A.enqueueAction(componentfunc);
        $A.get('e.force:refreshView').fire();
         
        var utilityAPI = component.find("utilitybar");
        utilityAPI.minimizeUtility({utilityAPI});
                                    
    },
    
   	handleContactSearch : function(component, event, helper) {

       	component.set('v.contactId','');
        var contactName = component.find("searchId").get("v.value"); 
        //alert(contactName);
        if(contactName === ''){
                component.set('v.contactList','');
        }else{
            var componentfunc = component.get('c.getConList');
        	componentfunc.setParams({
            contactName : contactName
        });
        componentfunc.setCallback(this,function(response){
            var state = response.getState();
           	console.log(state);
            if(state ==="SUCCESS"){
                var response = response.getReturnValue();
                console.log(response);
                component.set('v.contactList',response);
            }else if(state ==="ERROR"){
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                    errors[0].message);
                    }
                }     
            }
        });
        $A.enqueueAction(componentfunc);
            
        }
	},
                                    
    handleContactSelection : function(component, event, helper) {
        var eventOrigin = event.getSource();
        var id = eventOrigin.get('v.name');
        var nameOfcontact = eventOrigin.get('v.value');
        component.set('v.contactList','');
        component.set('v.contactId',id);
        component.set('v.SearchKey',nameOfcontact);
        console.log(eventOrigin.get('v.value'));
        console.log(component.get('v.contactId'));
        //alert(id);
        
    },
                                    
    handleAccSearch : function(component, event, helper) {

       	component.set('v.accId','');
        var accName = component.find("accSearchId").get("v.value"); 
        //alert(accName);
        if(accName === ''){
                component.set('v.accList','');
        }else{
            var componentfunc = component.get('c.getAccList');
        	componentfunc.setParams({
            accName : accName
        });
        componentfunc.setCallback(this,function(response){
            var state = response.getState();
           	console.log(state);
            if(state ==="SUCCESS"){
                var response = response.getReturnValue();
                console.log(response);
                component.set('v.accList',response);
            }else if(state ==="ERROR"){
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                    errors[0].message);
                    }
                }     
            }
        });
        $A.enqueueAction(componentfunc);
            
        }
	},
                                    
    handleAccSelection : function(component, event, helper) {
        var eventOrigin = event.getSource();
        var ids = eventOrigin.get('v.name');
        var nameOfacc = eventOrigin.get('v.value');
        component.set('v.accList','');
        component.set('v.acctId',ids);
        component.set('v.accSearchKey',nameOfacc);
        //alert(ids);
    }
})