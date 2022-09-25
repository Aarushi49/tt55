trigger AccountTrigger on Account (before insert,before update) {
    if(Trigger.isbefore && (Trigger.isInsert || Trigger.isUpdate)){
        DeactivateTriggers__c triggerStatus = DeactivateTriggers__c.getInstance('Account Trigger');
        if(triggerStatus == null || (triggerStatus != null && triggerStatus.isActive__c) ){
            //AccountTriggerHandler.beforeAccount();
        }
    }
    
}