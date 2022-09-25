trigger CountMax on Contact (after insert, after update, after delete) {
   
    /*Set<Id> accid= new Set<Id>();
    List<Account> accList = new List<Account>();
    //accList=[Select id, MaxSalary__c, MinSalary__c from Account];
   
    for(Contact con:Trigger.new){
        accid.add(con.AccountId);
    }
   
    for(AggregateResult ar: [Select AccountId, MAX(Salary__c) maxsal, MIN(Salary__c) minsal from Contact where AccountId IN: accid Group by AccountId]){
        accList.add(new Account(Id=(Id)ar.get('AccountId'), MaxSalary__c=(Decimal)ar.get('maxsal'), MinSalary__c=(Decimal)ar.get('minsal')));
    } 
   
    update accList;*/
}