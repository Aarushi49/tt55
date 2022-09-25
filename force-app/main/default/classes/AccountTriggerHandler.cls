public class AccountTriggerHandler {
    public static void beforeAccount(){
        
        system.debug('trigger.new--'+trigger.new );
        system.debug('trigger.oldmap--'+trigger.oldmap );
        
        map<Id,Account> accOldMap = (map<Id,Account>) trigger.oldMap;
        List<Account> accList = trigger.new;
        
        map<String,Integer> accMapToCount = new map<String,Integer>();
        list<String> uniqueNames = new list<String>();
        
        for(Account acc: accList){
            if(Trigger.isInsert || ((Trigger.isUpdate) && acc.Name != accOldMap.get(acc.id).Name)){
                if(!accMapToCount.containsKey(acc.Name)){
                    accMapToCount.put(acc.name,1);
                    uniqueNames.add(acc.Name);
                }else{
                    accMapToCount.put(acc.Name, accMapToCount.get(acc.Name)+1);
                }
            }
            
        }
        
        map<String,String> existingAccountsMap = new map<String,String>();
        if(uniqueNames.size() > 0){
            for(Account accExist : [Select id, Name from Account where name IN :uniqueNames ]){
                existingAccountsMap.put(accExist.Name,accExist.id);
            }
        }
        
        for(Account acc: accList){
            if(existingAccountsMap.containsKey(acc.Name)){
                acc.addError('Account already exists with same name at: '+existingAccountsMap.get(acc.Name) );
            }else if(accMapToCount.containsKey(acc.Name) && accMapToCount.get(acc.Name) > 1){
                acc.addError('You are trying to insert duplicate accounts with name: '+ acc.Name);
            }  
        }
        
    }
}