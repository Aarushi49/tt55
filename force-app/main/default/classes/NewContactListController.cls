public class NewContactListController {

    @AuraEnabled
    public static list<Contact> getContacts(String accountId){
        system.debug('Account id here is --'+accountId);
       List<Contact> conlist =[Select Id , name,email,phone,AccountId,Account.Name from contact where AccountId =: accountId];
        return conlist;
    }
    
    @AuraEnabled
    public static Contact insertcontact(Contact con , String Accountid){
        system.debug('condede');
        con.AccountId = Accountid;
        insert con;
        system.debug('con id here is --'+con);
        return con;
    }
}