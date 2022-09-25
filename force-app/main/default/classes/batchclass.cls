global class batchclass implements Database.Batchable<sObject>,Database.Stateful{
     global double TotalEmployeeCount = 0;
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        String query='Select Description FROM Account';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC ,List<Account> scope)
    {
       

        for(Account a : scope)
        {//comment 2nd added removed hhhh
            //comment added here
            if(a.Description=='Not Anything')
            {
                a.Description='Please fill in the details,this is a warning';
            }
            TotalEmployeeCount++;
        }
         system.debug('NO of records processed are' + TotalEmployeeCount);
            update scope;
      
    }
 
    global void finish(Database.BatchableContext BC)
    {
         
        
    }
    
}