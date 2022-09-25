public class Autoaccount {
   
    public static void addcontactmethod(list<Contact> con)
    {
       list<Account> alist=new list<Account>();
       for(Contact c:con)
       {
           Account a=new Account();
           a=[Select No_of_Contacts__c,id from Account where id=:c.AccountId];
           list<Contact> alist2=new list<Contact>();
           alist2=[Select id,lastname from Contact where accountid=:a.Id];
           a.No_of_Contacts__c=alist2.size();
           
           
           if(a.No_of_Contacts__c==Null)
               a.No_of_Contacts__c=1;
           else
          	   a.No_of_Contacts__c=a.No_of_Contacts__c+1;
           
           alist.add(a);
           
       }
        update alist;
            
    }
    
    
    public static void delcontactmethod(list<Contact> con)
    {
       list<Account> alist=new list<Account>();
       for(Contact c:con)
       {
           Account a=new Account();
           a=[Select No_of_Contacts__c from Account where id=:c.AccountId];
           list<Contact> alist2=new list<Contact>();
           alist2=[Select id,lastname from Contact where accountid=:a.Id];
           a.No_of_Contacts__c=alist2.size();
           
           a.No_of_Contacts__c=a.No_of_Contacts__c-1;
           alist.add(a);
           
       }
        update alist;
            
    }
    
    
    
}