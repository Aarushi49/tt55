public class growthLoginController {
    public string Username{set;get;}
    public string password{set;get;}  
    public string ErrorMessage{set;get;}
    public growthLoginController(){
    }
    
    public void checkPassword(){
        try{
            system.debug('Username--'+Username);
            Employee__c emp=[select id,Username__c,Password__c,Name from Employee__c where Username__c =: Username];
            if(Username.equals(emp.Username__c)){
                if(password.equals(emp.Password__c)){
                    ErrorMessage = 'You have successsfully logged in'; 
                }else{
                    ErrorMessage = 'Passwords do not match';
                }
            }
        }catch(Exception e){
            ErrorMessage = 'Fill in the username and password correctly'; 
        }
        
    }
}