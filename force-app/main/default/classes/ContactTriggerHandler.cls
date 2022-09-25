public class ContactTriggerHandler {
    public static void beforeContact(){
        system.debug('trigger.new--'+trigger.new );
        system.debug('trigger.oldmap--'+trigger.oldmap );
        
        map<Id,Contact> conOldMap = (map<Id,Contact>) trigger.oldMap;
        List<Contact> conList = trigger.new;
        
        map<String,Integer> conMapToCount = new map<String,Integer>();
        list<String> uniqueNPI = new list<String>();
        set<String> accNamesSet = new set<String>();
        
        for(Contact con: conList){
            if(Trigger.isInsert || ((Trigger.isUpdate) && con.Name != conOldMap.get(con.id).Name)){
                if(!conMapToCount.containsKey(con.Name)){
                    conMapToCount.put(con.name,1);
                    uniqueNPI.add(con.Name);
                    if(con.Company__c != null && con.AccountId == null){
                        accNamesSet.add(con.Company__c);  
                    }
                }else{
                    conMapToCount.put(con.Name, conMapToCount.get(con.Name)+1);
                }
            }
        }
        
        map<String,String> existingContactsMap = new map<String,String>();
        if(uniqueNPI.size() > 0){
            for(Contact conExist : [Select id, Name from Contact where name IN :uniqueNPI ]){
                existingContactsMap.put(conExist.Name,conExist.id);
            } 
        }
        
        
        map<String,String> existingAccountsMap = new map<String,String>();
        if(accNamesSet.size() > 0){
            for(Account accExist : [Select id, Name from Account where name IN :accNamesSet ]){
                existingAccountsMap.put(accExist.Name,accExist.id);
            }
        }
        
        for(Contact con: conList){
            if(existingContactsMap.containsKey(con.Name)){
                con.addError('Contact already exists with same NPI number at: '+existingContactsMap.get(con.Name) );
            }else if(conMapToCount.containsKey(con.Name) && conMapToCount.get(con.Name) > 1){
                con.addError('You are trying to insert duplicate Contacts with NPI: '+ con.Name);
            }else{
                if(existingAccountsMap.containsKey(con.Company__c)){
                    con.AccountId = existingAccountsMap.get(con.Company__c);
                }
            }
        }
        
    }
}