trigger countcontacts on Contact (after insert,after update,after delete,after undelete) 
{
	  Set<id> accid = new set<id>();
      if(Trigger.IsInsert||Trigger.IsUpdate||Trigger.IsUndelete)
      {
          for(Contact c:Trigger.New)
          {
              if(String.isNotBlank(c.AccountId))
               accid.add(c.AccountId);
                  
          }
      }
    
      
      if(Trigger.IsDelete)
      {
          for(Contact c:Trigger.Old)
          {
              if(String.isNotBlank(c.AccountId))
               accid.add(c.AccountId);
                  
          }
      }
 
    list<Account> acc =new list<Account>();
    acc=[Select id,Name,No_of_Contacts__c,(Select id from Contacts) From Account where id IN:accid];
    for(Account a: acc)
    {
        a.No_of_Contacts__c=a.Contacts.size();
    }
    update acc;
    
}