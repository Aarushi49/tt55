trigger pencode on Parker_Pen__c (before insert,before update) {
    set<decimal> insertedpen = new set<decimal>();
    for(Parker_Pen__c pp:Trigger.New){
        if(pp.Code__c!=null){
          insertedpen.add(pp.Code__c);  
        }
    }
    map<decimal,string> mapofpen =new  map<decimal,string>();
    for(Parker_Pen__c pen:[select id,name,Code__c,Price__c from Parker_Pen__c where Code__c =:insertedpen]){
                    system.debug('inserted pen'+pen);
        if(!mapofpen.containskey(pen.Code__c)){
        mapofpen.put(pen.Code__c,pen.Name);
        }
        else if(mapofpen.containskey(pen.Code__c)){
            string s=mapofpen.get(pen.Code__c);
            s+=' , ' +pen.Name;
            mapofpen.put(pen.Code__c,s);        }
    }
    
    for(Parker_Pen__c addedpen:Trigger.New){
      if(addedpen.Code__c!=null && mapofpen.containsKey(addedpen.Code__c))  
      {
          addedpen.addError('duplicate code cannot exists '+mapofpen.get(addedpen.Code__c)+' already has it');
      }
    }
}