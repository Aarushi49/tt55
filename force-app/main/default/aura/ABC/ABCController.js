({
        doInit : function(component, event, helper) {
                component.set("v.columns" , [
                    {label: "FirstName", field: "FirstName", type: "text", editable:true},
                    {label: "LastName", field: "LastName", type: "text", editable:true}
                ]);
        
                var action = component.get("c.fetchContact");
                action.setParams({"recordId" : component.get("v.recordId")});
                action.setCallback(this, function(r) {
                var state = r.getState();
                    console.log('state--'+state);
                    console.log('state--'+r.getReturnValue());
                if(state === "SUCCESS") {
                    component.set("v.data" , r.getReturnValue());
                }
                });
                $A.enqueueAction(action);
            
        },
            getSelectedIds : function(component,event,helper) {
                var selRows = event.getParams("selectedRows");
                var selectedRowIds = [];
                for(var i=0;i<=selRows.length;i++){
                    selectedRowIds.push(selRows[i].Id);
                }
                component.set("v.selectedRowIds",selectedRowIds);
            },
            handleDelete : function(component,event,helper) {
                var selectedRowIds = component.get("v.selectedRowIds");
                var action = component.get("c.deleteContacts");
                action.setParams({"conIdList" : selectedRowIds});
                action.setCallback(this, function(r) {
                    var state = r.getState();
                    if(state === "SUCCESS") {
                        alert("Contact deleted successfully");
                    }
                });
                $A.enqueueAction(action);
            },
            handleSave : function(component,event,helper) {
                var action = component.get("c.saveContacts");
                action.setParams({"conList" : event.getParams("draftvalues")});
                action.setCallback(this, function(r) {
                    var state = r.getState();
                    if(state === "SUCCESS") {
                        alert("Contact saved successfully");
                    }
                });
                $A.enqueueAction(action);
            }
        })