public class SearchComponentHandler {
    
    @AuraEnabled
    public static list<SObject> findBeer(String SearchKey){
        String likeName ='%'+SearchKey+'%';
        String Query='';
        if(SearchKey != null){
          Query = 'Select id ,name__c,price__c,alcohol__c,image__c from beer__c where name__c like :likeName limit 10';
        }else{
          Query = 'Select id ,name__c,price__c,alcohol__c,image__c from beer__c limit 3';

        }
        
        list<SObject> slist = Database.query(Query);
        return slist;
    }
}