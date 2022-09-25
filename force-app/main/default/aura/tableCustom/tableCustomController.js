({
    doInit : function(component, event, helper) {
        //alert('doinit');
        var tasks = component.get("v.tasks");
        var stageName = component.get("v.stageName");
        component.set("v.tableData", tasks[stageName]);

        $A.createComponent(
            "lightning:spinner",
            {"alternativeText": "Loading" },
            function(loader, status, errorMessage) {
                if (status === "SUCCESS") {
                    var body = component.get("v.body");
                    body = [loader];
                    component.set("v.body", body);

                    $A.createComponent(
                        "c:customDataTable",
                        {
                            "aura:id": 'datatableId-' + component.get("v.tableIndex"),
                            "auraId": 'datatableId-' + component.get("v.tableIndex"),
                            "columns": component.get("v.columns") ,
                            "rollupColumns": component.get("v.rollupColumns"),
                            "data": component.get("v.tableData"),
                            "showRowNumberColumn": "true"
                        },
                        function(newtable, status, errorMessage){
                            //Add the new table to the body array
                            if (status === "SUCCESS") {
                                var body = component.get("v.body");
                                body = [newtable];
                                component.set("v.body", body);
                            }
                            else if (status === "INCOMPLETE") {
                                console.log("No response from server or client is offline.")
                                // Show offline error
                            }
                            else if (status === "ERROR") {
                                console.log("Error: " + errorMessage);
                                // Show error message
                            }
                        }
                    );
                }
            }
        )
    },

    saveTableRecords : function(component, event, helper) {
        var recordsData = event.getParam("recordsString");
        var tableAuraId = event.getParam("tableAuraId");
        var action = component.get("c.updateRecords");

        action.setParams({
            jsonString: recordsData
        });
        action.setCallback(this,function(response){
            var datatable = component.find(tableAuraId);
            var state = response.getState();
            var message = null;
            if (state === 'ERROR') {
                if (response.getError()[0]) {
                    message = response.getError()[0].message;
                    if (message.includes('FIELD_CUSTOM_VALIDATION_EXCEPTION')) {
                        message = message.split(",");
                        message = message[message.length - 1];
                    }
                } else {
                    message = 'Something went wrong! please contact admin';
                }
            }

            var tableData = null;
            if (state !== 'ERROR') {
                var tableData = component.get("v.tableData");
                var updatedRecords = response.getReturnValue();
                console.log(updatedRecords);
                if (updatedRecords.length) {
                    updatedRecords.forEach(function(record) {
                        tableData.forEach(function(row) {
                            if (row.Id === record.Id) {
                                row = Object.assign(row, record);                                
                                /* if (record.Status_Update__c) {
                                    var historyDateObj = new Date();
                                    var updaterName = component.get("v.currentUserName"); 
                                        
                                    var badgeClass = "slds-theme_success";
                                    var noOfDays = Math.ceil(((new Date()) - historyDateObj) / (86400 * 1000));
                                    if (noOfDays >= 6 && noOfDays < 14) {
                                        badgeClass = "slds-theme_warning";
                                    } else if (noOfDays > 14) {
                                        badgeClass = "slds-theme_error";
                                    }

                                    var formattedDate = ((historyDateObj.getMonth() + 1) + "/" + historyDateObj.getDate() + "/"  + historyDateObj.getFullYear());
                                    row.lastStatusUpdateMeta = {
                                        label: formattedDate,
                                        helpText: "<p><b>" + updaterName + "</b></p>" + record.Status_Update__c,
                                        badgeClass: badgeClass
                                    }
                                } */
                            }
                        })
                    })
                }
            }
            datatable.finishSaving(
                state,
                tableData,
                message
            );
        });
        $A.enqueueAction(action);        
    },
    newTask : function(component, event, helper) {
        var createRecordEvent = $A.get("e.force:createRecord");
        console.log('record id');
        console.log(component.get("v.rcdId"));

        createRecordEvent.setParams({
            "entityApiName": "Task",
            "defaultFieldValues":{ 
                "WhatId":component.get("v.rcdId"),
                "Closing_Checklist_Category__c":component.get("v.stageName")
            },
            "navigationLocation" : "LOOKUP",
            "panelOnDestroyCallback": function(event) {
                alert('check');
                var refreshEvent = component.getEvent("refreshTable");
                console.log(refreshEvent);
                refreshEvent.fire();
            }
        });
        createRecordEvent.fire();
        
        window.setTimeout(
            $A.getCallback(function() {
                var action = component.getEvent('refreshTableEvent');
                $A.enqueueAction(action);
                alert('check2233');            
            }), 1000
        );
    }
})