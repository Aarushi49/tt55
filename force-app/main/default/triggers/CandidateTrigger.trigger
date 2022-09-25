trigger CandidateTrigger on Candidate__c (before insert,before update) {
   
    map<string,list<Candidate__c>> candmap = new map<string,list<Candidate__c>>();
    list<string> candups= new list<string>();
    
    for(Candidate__c c :Trigger.New){
        if(!candmap.containsKey(c.email__c)){
            candmap.put(c.email__c,new list<Candidate__c>());
        } 
        candmap.get(c.email__c).add(c);
    }
    
    for(Candidate__c cd : [select id, email__C from Candidate__c where email__c in:candmap.keyset() ]){
        candups.add(cd.email__c);
    }
     
    for(Candidate__c cand :trigger.new){
        if(candups.contains(cand.email__c)){
          cand.addError('Candidate already exists with this email');
        }
        else if(candmap.get(cand.email__c).size()>1){
           cand.addError(' 2 Candidates cannot be inserted with same email');

        }
    }
}