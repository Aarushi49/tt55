({
    fetchCurrentUserName: function(component) {
        var action = component.get("c.getUserName");
        action.setCallback(this, function(response) {
            if (response.getState() === 'SUCCESS') {
                component.set("v.currentUserName", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },

    setupTable : function(component) {
        var action = component.get("c.getPicklistValues");
        action.setParams({
            objectAPIName: "Task",
            fieldAPINames: ["Applicable__c","Status"]
        });
        action.setCallback(this,function(response){
            if(response.getState() === "SUCCESS"){
                var applicableOptions = [];
                var statusOptions = [];
                console.log(response.getReturnValue());
                Object.entries(response.getReturnValue())
                      .forEach(([key, values]) => {
                          if (key === "Applicable__c") {
                            Object.entries(values).forEach(([optionLabel, optionValue]) => {
                                applicableOptions.push({label: optionLabel, value: optionValue})
                            })
                          }
                          if (key === "Status") {
                            Object.entries(values).forEach(([optionLabel, optionValue]) => {
                                statusOptions.push({label: optionLabel, value: optionValue})
                            })
                          }
                      });

                var cols = [
                    {label: "Applicable", fieldName: "Applicable__c", editable: true, resizable: true, type:"picklist", selectOptions: applicableOptions, sortable: true},
                    {label: "Task Name", fieldName: "taskLink", editable: true, type: "link", sortable: true, resizable: true, 
                     attributes: { label: {fieldName:"Subject"}, title:"Click to View(New Window)", target:"_blank"},
                     width: 300},
                    {label: "Task Status", fieldName: "Status", resizable: true, editable: true, type:"picklist", selectOptions: statusOptions, sortable: true},
                    {label: "Notes", fieldName: "Description", resizable: true, editable: true},
                    {label: "Assignee", fieldName: "users", type: 'avatars', resizable: true, editable: false}
                ];
                component.set("v.columns", cols);
                this.loadRecords(component);
            }else{
                var errors = response.getError();
                var message = "Error: Unknown error";
                if(errors && Array.isArray(errors) && errors.length > 0)
                    message = "Error: "+errors[0].message;
                component.set("v.error", message);
                console.log("Error: "+message);
            }
        });
        $A.enqueueAction(action);
    },
                    
    loadRecords : function(component) {
        var stages = [];
        var offeringId = component.get("v.recordId");
        var action = component.get("c.fetchTasks");
        action.setParams({ 
            offeringId: offeringId
        });

        action.setCallback(this,function(response){
            if(response.getState() === "SUCCESS"){
                var allRecords = response.getReturnValue();
                Object.entries(allRecords).forEach(([stage, records]) => {
                    stages.push(stage);
                    records.forEach(rec => {
                        // var randomColorIndex = Math.floor(Math.random() * 10);
                        rec.taskLink = '/lightning/r/' + rec.Id + '/view';
                    })
                });
                component.set("v.tasks", allRecords);
                component.set("v.stages", stages);
                console.log("stages: "+stages);
  
                component.set("v.isLoading", false);
            }else{
                var errors = response.getError();
                var message = "Error: Unknown error";
                if(errors && Array.isArray(errors) && errors.length > 0)
                    message = "Error: "+errors[0].message;
                component.set("v.error", message);
                console.log("Error: "+message);
            }
        });
        $A.enqueueAction(action);
    },
})