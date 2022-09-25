({
	doInit : function(component, event, helper) {
		var pageReference = component.get('v.pageReference');
        var state = pageReference.state;
        component.set('v.beerId', state.c__beerId);
        component.find("recordViewer").reloadRecord();
        
        component.find("newRecordCreator").getNewRecord(
            "Beer_Order__c", // sObject type (objectApiName)
            null,      // recordTypeId
            false,     // skip cache?
            $A.getCallback(function() {
                var rec = component.get("v.newRecordObject");
                var error = component.get("v.newRecordError");
                if(error || (rec === null)) {
                    console.log("Error initializing record template: " + error);
                    return;
                }
                console.log("Record template initialized: " + rec.apiName);
            })
        ); 
	},
    
    handleSubmit : function(component, event, helper) {
        var beerRecord = component.get('v.simpleRecord');
        var quantity =component.get('v.beerOrder.Ordered_Quantity__c');
        var totalPrice = parseInt(beerRecord.Price__c) * parseInt(quantity);
        if(component.get("v.beerOrder.Billing_Same_as_Shipping__c")){
            component.set("v.beerOrder.Billing_Street__c",component.get("v.beerOrder.Shipping_Street__c"));
            component.set("v.beerOrder.Billing_City__c",component.get("v.beerOrder.Shipping_City__c"));
            component.set("v.beerOrder.Billing_Country__c",component.get("v.beerOrder.Shipping_Country__c"));
            component.set("v.beerOrder.Billing_State__c",component.get("v.beerOrder.Shipping_State__c"));
            component.set("v.beerOrder.Billing_Postal_Code__c",component.get("v.beerOrder.Shipping_Postal_Code__c"));
        }
        var isValid = helper.validateForm(component, event, helper);
        if(!isValid)
            return;
        var userId = $A.get("$SObjectType.CurrentUser.Id");
        component.set("v.beerOrder.Beer__c",component.get("v.beerId"));
        component.set("v.beerOrder.Ordered_By__c",userId);
        component.set("v.beerOrder.Order_Amount__c",parseInt(totalPrice));
        component.find("newRecordCreator").saveRecord($A.getCallback(function(saveResult) {
            // use the recordUpdated event handler to handle generic logic when record is changed
            if (saveResult.state === "SUCCESS" || saveResult.state === "DRAFT") {
                var resultsToast = $A.get("e.force:showToast");
                resultsToast.setParams({
                    "title" : "Order Placed",
                    "message" : "Your order has been successfully placed !!",
                    "type" : "success",
                });
               resultsToast.fire();
               var pagerefernceNav = component.find("navigatorOrderDetails");
                var pageReference = {
                    "type" : "standard__component",
                    "attributes": {
                        componentName: "c__OrderDetails"
                    },
                    "state": {
                        "c__orderId" : saveResult.recordId,
                    }
                };
                pagerefernceNav.navigate(pageReference);  
                
            } else if (saveResult.state === "INCOMPLETE") {
                console.log("User is offline, device doesn't support drafts.");
            } else if (saveResult.state === "ERROR") {
                console.log('Problem saving record, error: ' + JSON.stringify(saveResult.error));
                 var resultsToast = $A.get("e.force:showToast");
                resultsToast.setParams({
                    "title" : "Error",
                    "message" : JSON.stringify(saveResult.error),
                    "type" : "success",
                });
               resultsToast.fire();
            } else {
                console.log('Unknown problem, state: ' + saveResult.state + ', error: ' + JSON.stringify(saveResult.error));
            }
        }));
    }

})