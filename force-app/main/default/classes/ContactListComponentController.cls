public class ContactListComponentController {
    
    @AuraEnabled
    public static list<Contact> getContact(String accountid){
        list<Contact> conlist =  [select id,title, Phone,FirstName,LastName , email from contact where email != null and Accountid =:accountid];
        return conlist;
    }
    
    @AuraEnabled
    public static Contact insertContact(Contact con , Id AccountId){
        con.AccountId = AccountId;
        insert con;
        return con;
    }

}