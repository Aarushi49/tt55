public with sharing class newcontroller {
public Contact con{get;set;}
String conid;

public newcontroller(){

    conid=ApexPages.currentPage().getParameters().get('id');
    con=[Select id,Name,lOAN_AMOUNT__c,Level__c from Contact where id=:conid];
}

public pagereference save(){
update con;

String re = URL.getSalesforceBaseUrl().toExternalForm() + '/' + con.Id;
PageReference redirectPage = new PageReference(re); 
return redirectPage;  

}

}