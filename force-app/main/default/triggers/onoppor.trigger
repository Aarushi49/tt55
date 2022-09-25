trigger onoppor on Opportunity (after insert ,after update,after undelete,after delete) 
{	
    Set<id> accid=new set<id>();
    if(Trigger.Isinsert||Trigger.Isupdate||Trigger.Isundelete)
    {
       for(Opportunity o:Trigger.New)
          {
              if(String.isNotBlank(o.AccountId))
               accid.add(o.AccountId);
          }
    }
    
        if(Trigger.Isdelete)
    {
       for(Opportunity o:Trigger.Old)
          {
              if(String.isNotBlank(o.AccountId))
               accid.add(o.AccountId);
          }
    }
    
    list<Account> acclist=new list<Account>();
    acclist=[Select id,Name,Sum_Of_closedwon__c, (Select id,amount From Opportunities where StageName='Closed Won' )from Account Where id IN:accid];
	for(Account a:acclist)
    {     
        a.Sum_Of_closedwon__c=0;
        for(Opportunity o : a.Opportunities)
        {
           if(o.Amount==Null)
               o.Amount=0;
            
            a.Sum_Of_closedwon__c= a.Sum_Of_closedwon__c+o.Amount;
       
        }
    }
    update acclist;

}