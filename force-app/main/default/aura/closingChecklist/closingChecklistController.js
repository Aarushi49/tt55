({
    doInit : function(component, event, helper) {
        document.title = 'Due Diligence';
        component.set("v.isLoading", true);
        helper.fetchCurrentUserName(component);
        helper.setupTable(component);
    },
    refreshTable : function(component, event, helper){
        alert('oyeoye11');
        $A.get('e.force:refreshView').fire();
        alert('oyeoye22'); 
    }
})