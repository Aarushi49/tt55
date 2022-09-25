public class getAllData {

    @AuraEnabled(cacheable=true)
       public static List<Lead> getAllLeads(String SearchKey) {
        if(!String.isBlank(SearchKey)){
         return [SELECT Id, Name,Company,Email,Phone,Add_To_Call_List__c  from Lead where Name like : '%'+SearchKey+'%' OR Email like :  '%'+SearchKey+'%'  OR  Phone  like :  '%'+SearchKey+'%'];
        }else{
         return [SELECT Id, Name,Company,Email,Phone,Add_To_Call_List__c  from Lead ];
        }
     }

    @AuraEnabled(cacheable=true)
       public static List<Contact> getAllConts(String SearchKey) {
        if(!String.isBlank(SearchKey)){
          return [SELECT Id, Name,Account.Name,Email,Phone,Add_To_Call_List__c  from Contact where Name like : '%'+SearchKey+'%' OR Email like :  '%'+SearchKey+'%'  OR  Phone  like :  '%'+SearchKey+'%'];
        }else{
          return [SELECT Id, Name,Account.Name,Email,Phone,Add_To_Call_List__c  from Contact];
        }

     }


     @AuraEnabled(cacheable=true)
       public static List<Account> getAllAccts(String SearchKey) {
        if(!String.isBlank(SearchKey)){
            return [SELECT Id, Name,Phone,Add_To_Call_List__c from Account where Name like : '%'+SearchKey+'%' OR  Phone  like :  '%'+SearchKey+'%'];
        }else{
            return [SELECT Id, Name,Phone,Add_To_Call_List__c from Account];
        }

     } 

     @AuraEnabled(cacheable=true)
       public static void updateRecords(String sobjectType, list<sObject> sobjectList) {
        list<sObject> sobjectUpdateList = new list<sObject>();
           for(Sobject s : sobjectList){
            //s.Add_To_Call_List__c = true;
            sobjectUpdateList.add(s);
           }

           update sobjectUpdateList;
       
    }

 }