trigger ContactTrigger on Contact (before insert,before update) {
    if(Trigger.isbefore && (Trigger.isInsert || Trigger.isUpdate)){
        DeactivateTriggers__c triggerStatus = DeactivateTriggers__c.getInstance('Contact Trigger');
        if(triggerStatus == null || (triggerStatus != null && triggerStatus.isActive__c) ){
            //iggerHandler.beforeContact();
        }
    }
}