public class contactListController {
    @Auraenabled
    public static list<sObject> getConList(String contactName){
        String likeParam = '%'+contactName+'%';
        String query ='';
        if(contactName != null)
            query ='Select Id, name from Contact where name like : likeParam ';
        
        list<sObject> sll = Database.query(query);
        return sll;
        
    }
    
    @Auraenabled
    public static list<sObject> getAccList(String accName){
        String likeParam = '%'+accName+'%';
        String query ='';
        if(accName != null)
            query ='Select Id, name from Account where name like : likeParam ';
        
        list<sObject> sll = Database.query(query);
        return sll;
        
    }
    
    @Auraenabled
    public static String getAcc(String accId){
        String query ='';
        if(accId != null)
            query ='Select Id, name from Account where id =: accId LIMIT 1';
        
        Account acc = Database.query(query);
        return acc.Name;
        
    }
    
    @Auraenabled
    public static void createTask(String accId , String subject , String comments , String notes , String conId){
        Task t = new Task();
        t.Subject = subject;
        t.Description = comments;
        t.TaskSubtype ='Call';
        t.notes__c = notes;
        t.Status ='Completed';
        t.OwnerId = system.UserInfo.getUserId();
        t.ActivityDate = system.today();
        t.WhatId = accId;
        t.WhoId = conId;
        Insert t;
        
        Account acc= new Account(id=accId);
        acc.Last_Logged_Call__c = system.now();
        update acc;
    }
}