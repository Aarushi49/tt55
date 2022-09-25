global class onlinetestclass {
       
      public list<Question__c> qlist{set;get;}
      public String cid{get;set;}
      public String maxQues{get;set;}
      public Candidate__c cand{set;get;}
      public integer c{get;set;}
      
      public onlinetestclass()
      { 
        qlist=new list<Question__c>();
       
        cid='';
        cand= new Candidate__c();
        c = [SELECT COUNT() FROM Question__c] ; 
        maxQues = String.valueOf(C);
        Map<String, String> paramMap = ApexPages.currentPage().getParameters();
          if(paramMap.containsKey('id')){
              cid=paramMap.get('id');
              cand = [SELECT Name,First_Name__c,Score__c,Email__c,Current_Employer__c,Last_Name__c,Education__c,Country__c FROM Candidate__c WHERE Id=:cid];
          }
        
      }
      
      
      public void testdisplay()
       {
          qlist=[Select id,Name,Multianswers__c,QStatement__c,(select id,Name,Ans_statement__c from Answers__r ORDER BY Name) from Question__c Order by Id] ;
         
          
       }
       
     
    @RemoteAction
    global static String saveResult(Map<String, String> reqData,String candidateId){
        system.debug('reqData--'+reqData);
        String res='';
        Integer count = 0;
        Integer attempted;
        Map<String, String> correctAnsMap = new Map<String, String>();
        
        for(Answer__c ans:[Select Question__r.id,id from Answer__c where Correct_or_not__c =true]){
            if(correctAnsMap.containsKey(ans.Question__r.id)){
                String temp = correctAnsMap.get(ans.Question__r.id);
                temp +=','+ans.Id;
                correctAnsMap.put(ans.Question__r.id,temp);
            }else{
                correctAnsMap.put(ans.Question__r.id,ans.Id);
            }
        }
        
        
       for(String qid:reqData.keyset()){
            String ansStr = reqData.get(qid);
            List<String> ansList = ansStr.split(',');
            Set<String> ansSet = new set<string>();
          
            for(String s:ansList){
            ansSet.add(s);
            }
            
            List<String>correctansList= correctAnsMap.get(qid).split(',');
                if((ansSet.size()==correctansList.size()) && ansSet.containsAll(correctansList)){
                   
                    count++;
                }else{
                    
                }
           }
         
       
        
        if(String.isNotBlank(candidateId)){
            List<Candidate__c> canList = [SELECT Id,Score__c FROM Candidate__c WHERE Id=:candidateId];
            if(!canList.isEmpty()){
                Candidate__c can = canList.get(0);
                can.Score__c = count;
                
                update can;
            }
            
        }
        
        res = String.valueOf(count);
        return res;  
        
        
        }  
        
    }