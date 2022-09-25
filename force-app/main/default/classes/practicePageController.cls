public class practicePageController {
    public string buttonValue{get;set;}
    public boolean show {get;set;}
    public integer buttonValueLength{get;set;}
    public practicePageController(){
        show=false;
    }
    public void printStatic(){
        show=true;
      system.debug('Commandbutton---'+buttonValue);  
    }
    public void printDynamic(){
        system.debug('Heyyyy222');
      buttonValue=apexpages.currentPage().getParameters().get('passValue');
      buttonValueLength=buttonValue.length();
        system.debug('ActionFunction---'+buttonValue);
        
    }
}