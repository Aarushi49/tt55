trigger LeadTrigger on Lead (after insert,after update) { 
    if(Trigger.isafter){ 
        map<id,lead> newMap = (map<id,lead>) Trigger.newMap;
        map<id,lead> oldMap = (map<id,lead>) Trigger.oldmap;
        
        system.debug('new--'+newMap);
        system.debug('old--'+oldMap);
        
        for(Lead l : trigger.new){
            if((newMap.get(l.id).IsConverted == true && newMap.get(l.id).Status == 'Closed - Converted') && newMap.get(l.id).ConvertedAccountId != null && ((trigger.isinsert ) || (trigger.isupdate && oldMap.get(l.id).IsConverted == false && oldMap.get(l.id).Status != newMap.get(l.id).Status))){
                Task t = new Task();
                t.Subject = 'Follow up with' + ' ' + [select name from account where id = : newMap.get(l.id).ConvertedAccountId].name;
                t.IsReminderSet = true;
                t.OwnerId = system.UserInfo.getUserId();
                Date futureDate = system.today().addDays(7);
                Datetime futureDateTime = Datetime.newInstance(futureDate.year(), futureDate.Month(), futureDate.Day(), 09,30,00);
                t.ActivityDate = futureDate;
                t.ReminderDateTime = futureDateTime;
                t.WhatId = newMap.get(l.id).ConvertedAccountId;
                Insert t;
            }
        }
    }
    
}