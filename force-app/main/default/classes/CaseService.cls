public with sharing class CaseService {
    public static void closeCases(set<ID> caseIDs, String newReason)
    {
        //Validate parameters
        if(caseIDs ==null || caseIDs.size() == 0)
        {
            throw new CaseServiceException('Cases not specified');
        }
        
        if(newReason == null || newReason == '')
        {
            throw new caseServiceException('Invalide reason provided');
        }
        
        //Query cases
        List<Case> casesToClose = [select Id, Status, Reason  from Case where Id IN :caseIDs];
        List<Case> updatedCases = new List<Case>();
        
        for(Case caseToUpd : casesToClose)
        {
            caseToUpd.Status = 'Closed';
            caseToUpd.Reason = newReason;
            updatedCases.add(caseToUpd);
        }
        
        //Update database
        SavePoint sp = Database.setSavepoint();
        try
        {
        update updatedCases;
        }
        catch(Exception e)
        {
            //Rollback
            Database.rollback(sp);
            //Throw expecetion on to caller
            throw e;
        }
    }
    
    public class CaseServiceException extends Exception{}

}