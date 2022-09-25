public without sharing class Controllerclass2
{
    
     public string accid{get;set;}
     public string delvalue{get;set;}
     public Contact con{set;get;}
     public list<Contact> contlist{set;get;}
     public Controllerclass2(ApexPages.StandardController SC)
     {
        contlist=null;
        con = new Contact();
     }
     
     public void tcontacts()
     {
         if(con!=null)
         {
            accid= con.AccountId ;
            List<Contact> conlist=[Select id,lastname from contact where accountid=:accid];
            
             if(!conlist.isEmpty())
             {
                contlist = conlist;
             }
             else
             {
                 contlist=null;
                 
             }  
         }
       }
       
        public void refreshlist()
       {
        contlist=[Select id,lastname from contact where accountid=:accid];
       
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
           }
       
       
       refreshlist();
      
       }
      
      
  }