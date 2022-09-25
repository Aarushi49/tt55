public class AccountListController {

    @AuraEnabled
    public static list<Account> getAccount(){
        list<Account> acclist =[select Name,OwnerId,BillingAddress from Account];
        system.debug('hey');
        return acclist;
    } 
}