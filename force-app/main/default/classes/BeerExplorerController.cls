public class BeerExplorerController {
    
    @Auraenabled
    public static list<sObject> getBeer(String beername){
        String likeParam = '%'+beername+'%';
        String query ='';
        if(beername != null)
             query ='Select Id,name__c,Price__c,id__c,alcohol__c from Beer__c where name__c like : likeParam LIMIT 10';
        else
             query ='Select Id,name__c,Price__c,id__c,alcohol__c  from Beer__c LIMIT 10';
        
        list<sObject> sll = Database.query(query);
        return sll;
        
    }
}