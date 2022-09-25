public class flowController {
    public Flow.Interview.create_case flDemo {get;set;}   
    
    public flowController(ApexPages.StandardController controller){
        //currentRecordId  = ApexPages.CurrentPage().getparameters().get('id');
    }
    // Instanciate the Flow for use by the Controller - linked by VF "interview" attribute
    public String strOutputVariable {
        get {
            String strTemp = '';
            
            if(flDemo != null) 
            {
                strTemp = string.valueOf(flDemo.getVariableValue('NewCaseId'));
                system.debug('NewCaseId--'+strTemp );
            }
            
            return strTemp;
        }
        
        set { strOutputVariable = value; }
    } 
    // Factor your PageReference as a full GET/SET
    public PageReference prFinishLocation {
        get {
            String url = System.URL.getSalesforceBaseUrl().toExternalForm()+'/'+strOutputVariable;
            system.debug('url--'+url);
            PageReference prRef = new PageReference(url);
            prRef.setRedirect(true);
            return prRef;
        }
        set { prFinishLocation = value; }
    }
    
    // Factor your Flow output variable pull as a full GET / SET
    
    
}