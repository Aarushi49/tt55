public without sharing class Controllerclass
{
    
     public string accid{get;set;}
     public string delvalue{get;set;}
     public Contact con{set;get;}
     public list<Contact> contlist{set;get;}
     public string urlvalue{set;get;}
     public Controllerclass(ApexPages.StandardController SC)
     {
        contlist=null;
        con = new Contact();
      
         urlvalue=Apexpages.currentPage().getUrl();
         if(urlvalue.contains('AccountId'))
        {
        
          accid=ApexPages.CurrentPage().getparameters().get('AccountId');
          refreshlist();
          
        }
       
     }
     
     public void tcontacts()
     {
         if(con!=null)
         {
            accid= con.AccountId ;
            if(accid==null)
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please select an account')); 
            else
            {
                         List<Contact> conlist=[Select id,lastname,Accountid,lOAN_AMOUNT__c from contact where accountid=:accid];
                        
                         if(!conlist.isEmpty())
                         {
                            contlist = conlist;
                         }
                         else
                         {
                             contlist=null;
                             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Acccount has no related contacts'));
                             
                         } 
             } 
        }
         
    }
       
        public void refreshlist()
       {
        
        contlist=[Select id,lastname,Accountid,lOAN_AMOUNT__c from Contact where accountid=:accid];
       
       }
       
       public void deletemethod()
       {
       
       if(delvalue==null)
       { 
       return;
       }
       
           Contact cc=null;
           for(Contact c:contlist)
           {
              if(c.id == delvalue)
               {
               cc=c;
               break;
               }
           }
           if(cc!=null)
           {
             delete cc;
             refreshlist();
      
           }
       
       
      
       }
      
      
  }