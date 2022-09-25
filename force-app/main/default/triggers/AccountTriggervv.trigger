trigger AccountTriggervv on Account (after insert) {
    list<contact> ConList = New list<contact> ();
    list<opportunity> OppList = New list<opportunity> ();
    OpportunityContactRole VarTemp = New OpportunityContactRole ();
   //Check context var
    if(Trigger.isAfter && Trigger.isInsert){
        for(Account acc : Trigger.New){
            Contact con = New Contact();
            Opportunity opp = New Opportunity();            
            con.AccountId = acc.Id;
            con.LastName = 'Sample Contact';
           
            opp.AccountId = acc.Id;
            opp.Name = 'Sample Oppty';
            opp.StageName = acc.Type;
            opp.CloseDate=date.today();
            ConList.add(con);
            OppList.add(opp);            
        }
        //Insert all records to Contact and Oppty
        insert ConList;
        insert OppList;
       
        list<contact> VarCon2 = New list<contact> ();
        VarCon2 = [SELECT id from Contact where Id in: ConList];
       
        list<opportunity> VarOpp2 = New list<opportunity> ();
        VarOpp2 = [SELECT id from Opportunity WHERE Id in: OppList];
       
        list<OpportunityContactRole> VarTempList = New list<OpportunityContactRole> ();
        for(contact VarCon: VarCon2){
            OpportunityContactRole tempVar = New OpportunityContactRole();
            tempVar.ContactId = VarCon.Id;
            VarTempList.add(tempVar);
        }
       
        for(Opportunity VarOpp : VarOpp2){
            OpportunityContactRole tempVar = New OpportunityContactRole();
            tempVar.OpportunityId = VarOpp.Id;
            VarTempList.add(tempVar);
        }        
        insert VarTempList;
    }
}