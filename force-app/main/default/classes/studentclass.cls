public class studentclass
{
       public static void student_func(list<Name__c> Mylist)
       {
         for(Name__c n:Mylist)
         {
             if(n.Age__c<30 && n.Experience__c>8)
             {
                 n.Status__c='Selected';
                 system.debug('hey there,candidate is selected');
                 
             }
              else
             {
                 n.Status__c='Not Selected';
                 system.debug('hey there,candidate is not selected');
             }
       
           }
        }
    
     
    
     public static void student_func3(list<Name__c> Mylist)
       {
         for(Name__c n:Mylist)
         {
             if(n.OwnerId!=Userinfo.getUserid())
             {
                 n.addError('Only owner can delete');
                 
             }
       
           }
        }
 }