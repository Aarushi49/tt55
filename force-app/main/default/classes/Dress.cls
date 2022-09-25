public class Dress {
    public static integer NoOfDresses=0;
    public integer size;
    public string color;
    
    public Dress(){
       NoOfDresses++; //NoOfDresses=NoOfDresses+1;
    }
    
    public void CreateDress(){
        system.debug('new dress');
    }
    
    public static void ChangeDress(){
        system.debug('change dress');
    }

}